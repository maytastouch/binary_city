import 'package:binary_city/core/common/entities/client_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/common/entities/contact_entity.dart';
import '../../../../../core/error/failures.dart';

abstract interface class AddClientRepository {
  // add client to database
  Future<Either<Failure, ClientEntity>> addClient({
    required String name,
    required List<String> contactIds,
    required List<String> contacts,
  });

  //get all contacts
  Future<Either<Failure, List<ContactEntity>>> getAllContacts();
}
