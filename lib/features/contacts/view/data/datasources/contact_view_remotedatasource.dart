import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/common/models/contact_model.dart';

abstract interface class ContactViewRemoteDataSource {
  //get all contacts
  Future<List<ContactModel>> getAllContacts();
}

class ContactViewRemoteDataSourceImpl implements ContactViewRemoteDataSource {
  final SupabaseClient supabaseClient;

  ContactViewRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<List<ContactModel>> getAllContacts() async {
    try {
      final contactList =
          await supabaseClient.from(AppConstants.contactsTable).select("*");

      return contactList
          .map(
            (client) => ContactModel.fromJson(client),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
