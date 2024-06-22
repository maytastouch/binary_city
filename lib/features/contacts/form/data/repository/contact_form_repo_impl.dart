import 'package:binary_city/core/error/exceptions.dart';
import 'package:binary_city/core/error/failures.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../../domain/repository/contact_form_repo.dart';
import '../datasources/contact_form_remote_datasource.dart';

class ContactFormRepositoryImpl implements ContactFormRepository {
  final ContactFormRemoteDataSource dataSource;

  ContactFormRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, void>> createContact(
      {required String firstName,
      required String lastName,
      required String email}) async {
    try {
      await dataSource.createContact(
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
