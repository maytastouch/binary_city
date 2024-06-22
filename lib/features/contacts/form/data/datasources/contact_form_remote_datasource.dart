import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ContactFormRemoteDataSource {
  //create a contact
  Future<void> createContact({
    required String firstName,
    required String lastName,
    required String email,
  });
}

class ContactFormRemoteDataSourceImpl implements ContactFormRemoteDataSource {
  final SupabaseClient supabaseClient;

  ContactFormRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<void> createContact(
      {required String firstName,
      required String lastName,
      required String email}) async {
    try {
      await supabaseClient.from(AppConstants.contactsTable).insert({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      });
      return;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
