import 'package:binary_city/core/error/failures.dart';
import 'package:binary_city/core/usecase/usecase.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../repository/contact_form_repo.dart';

class CreateContactUseCase implements UseCase<void, CreateContactParams> {
  final ContactFormRepository repository;

  CreateContactUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(CreateContactParams params) async {
    return repository.createContact(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
    );
  }
}

class CreateContactParams {
  final String firstName;
  final String lastName;
  final String email;

  CreateContactParams({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}
