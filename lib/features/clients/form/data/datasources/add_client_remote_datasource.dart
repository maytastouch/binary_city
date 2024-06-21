import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AddClientRemoteDataSource {
  // Add client to database
  Future<void> addClient({
    required String name,
  });
}

class AddClientRemoteDatasourceImpl implements AddClientRemoteDataSource {
  final SupabaseClient supabaseClient;

  AddClientRemoteDatasourceImpl(this.supabaseClient);
  @override
  Future<void> addClient({required String name}) async {
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

      await supabaseClient
          .from(AppConstants.clientStable)
          .insert({'name': name, 'client_code': clientCode});

      // Optionally, return or log the clientCode if needed
      print('Client code generated: $clientCode');
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
