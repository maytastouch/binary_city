import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/common/models/contact_model.dart';

abstract interface class AddClientRemoteDataSource {
  // Add client to database
  Future<Map<String, dynamic>> addClient({
    required String name,
    required List<String> contactIds,
  });

  // Get all contacts
  Future<List<ContactModel>> getAllContacts();
}

class AddClientRemoteDatasourceImpl implements AddClientRemoteDataSource {
  final SupabaseClient supabaseClient;

  AddClientRemoteDatasourceImpl(this.supabaseClient);

  @override
  Future<Map<String, dynamic>> addClient(
      {required String name, required List<String> contactIds}) async {
    try {
      // Extract the first three characters and convert to uppercase
      String clientCodeAlpha = name.length >= 3
          ? name.substring(0, 3).toUpperCase()
          : name.toUpperCase();

      // If the name is shorter than 3 characters, fill it up with alphabets starting from A
      int asciiValue = 65; // ASCII value of 'A'
      while (clientCodeAlpha.length < 3) {
        clientCodeAlpha += String.fromCharCode(asciiValue);
        asciiValue++;
      }

      // Ensure the alpha part is exactly 3 characters
      clientCodeAlpha = clientCodeAlpha.substring(0, 3);

      // Fetch the maximum numeric code from the database
      final maxCodeResponse = await supabaseClient
          .from(AppConstants.clientStable)
          .select('client_code')
          .order('client_code', ascending: false)
          .limit(1)
          .maybeSingle();

      int numericCode = 1;
      if (maxCodeResponse != null &&
          maxCodeResponse.containsKey('data') &&
          maxCodeResponse['data'] != null &&
          maxCodeResponse['data'].isNotEmpty) {
        String maxCode = maxCodeResponse['data'][0]['client_code'];
        numericCode = int.parse(maxCode.substring(3)) + 1;
      }

      // Generate a unique client code
      String clientCode;
      bool isUnique = false;
      do {
        clientCode = clientCodeAlpha + numericCode.toString().padLeft(3, '0');
        final response = await supabaseClient
            .from(AppConstants.clientStable)
            .select('client_code')
            .eq('client_code', clientCode)
            .maybeSingle();

        if (response == null || response.containsKey('error')) {
          isUnique = true;
        } else {
          numericCode++;
        }
      } while (!isUnique);

      final insertResponse = await supabaseClient
          .from(AppConstants.clientStable)
          .insert({'name': name, 'client_code': clientCode})
          .select()
          .single();

      final clientId = insertResponse['client_id'];

      // Link contacts to the client
      if (contactIds.isNotEmpty) {
        final List<Map<String, dynamic>> clientContactLinks = contactIds
            .map(
                (contactId) => {'client_id': clientId, 'contact_id': contactId})
            .toList();

        await supabaseClient
            .from(AppConstants.linkTable)
            .insert(clientContactLinks);
      }

      // Query to count the number of linked contacts for the newly created client
      final contactsCountResponse = await supabaseClient
          .from(AppConstants
              .linkTable) // Assuming 'client_contacts' is the table name
          .select('contact_id')
          .count(CountOption
              .exact); // Assuming 'contact_id' is the column to count

      int contactsCount = 0;
      if (contactsCountResponse.data.isNotEmpty) {
        contactsCount = contactsCountResponse
            .data.length; // Or use the count property if available
      }
      // Return both clientId and contactsCount
      return {'clientId': clientId, 'numberOfLinkedContacts': contactsCount};
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ContactModel>> getAllContacts() async {
    try {
      final response =
          await supabaseClient.from(AppConstants.contactsTable).select("*");
      return response
          .map<ContactModel>((e) => ContactModel.fromJson(e))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
