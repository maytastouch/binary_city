import 'package:fpdart/fpdart.dart';

import '../../../../../core/common/entities/contact_entity.dart';
import '../../../../../core/error/failures.dart';

abstract interface class AddClientRepository {
  // add client to database
  Future<Either<Failure, String>> addClient({
    required String name,
  });

  //get all contacts
  Future<Either<Failure, List<ContactEntity>>> getAllContacts();
}
