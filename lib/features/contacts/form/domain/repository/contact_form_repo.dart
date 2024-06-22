import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failures.dart';

abstract interface class ContactFormRepository {
  //create contact
  Future<Either<Failure, void>> createContact({
    required String firstName,
    required String lastName,
    required String email,
  });
}
