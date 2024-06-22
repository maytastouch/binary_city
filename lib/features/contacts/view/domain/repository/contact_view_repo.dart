import 'package:binary_city/core/common/entities/contact_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failures.dart';

abstract interface class ContactViewRepository {
  //get all contacts
  Future<Either<Failure, List<ContactEntity>>> getAllContacts();
}
