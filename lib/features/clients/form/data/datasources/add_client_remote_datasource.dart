import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/common/models/client_model.dart';
import '../../../../../core/common/models/contact_model.dart';

abstract interface class AddClientRemoteDataSource {
  // Add client to database
  Future<ClientModel> addClient({
    required String name,
    required List<String> contactIds,
    required List<String> contacts,
  });

  // Get all contacts
  Future<List<ContactModel>> getAllContacts();
}

class AddClientRemoteDatasourceImpl implements AddClientRemoteDataSource {
  final SupabaseClient supabaseClient;

  AddClientRemoteDatasourceImpl(this.supabaseClient);

  @override
  Future<ClientModel> addClient({
    required String name,
    required List<String> contactIds,
    required List<String> contacts,
  }) async {
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

      final client = await supabaseClient
          .from(AppConstants.clientStable)
          .upsert({
            'name': name,
            'client_code': clientCode,
          }, onConflict: 'name')
          .select()
          .single();
      ClientModel singleClient = ClientModel.fromJson(client);

      return singleClient;
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
