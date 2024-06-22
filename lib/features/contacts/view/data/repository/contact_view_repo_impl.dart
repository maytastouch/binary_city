import 'package:binary_city/core/common/entities/contact_entity.dart';
import 'package:binary_city/core/error/exceptions.dart';

import 'package:binary_city/core/error/failures.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../../domain/repository/contact_view_repo.dart';
import '../datasources/contact_view_remotedatasource.dart';

class ContactViewRepositoryImpl implements ContactViewRepository {
  final ContactViewRemoteDataSource contactViewDataSource;

  ContactViewRepositoryImpl(this.contactViewDataSource);
  @override
  Future<Either<Failure, List<ContactEntity>>> getAllContacts() async {
    try {
      final contactList = await contactViewDataSource.getAllContacts();
      return Right(contactList);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
