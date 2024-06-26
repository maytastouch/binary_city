import 'package:binary_city/core/common/entities/contact_entity.dart';
import 'package:binary_city/core/error/exceptions.dart';
import 'package:binary_city/core/error/failures.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../../../../../core/common/models/client_model.dart';
import '../../domain/repository/add_client_repo.dart';
import '../datasources/add_client_remote_datasource.dart';

class AddClientRepositoryImpl implements AddClientRepository {
  final AddClientRemoteDataSource addClientRemoteDataSource;

  AddClientRepositoryImpl(this.addClientRemoteDataSource);
  @override
  Future<Either<Failure, ClientModel>> addClient({
    required String name,
    required List<String> contactIds,
    required List<String> contacts,
  }) async {
    try {
      final res = await addClientRemoteDataSource.addClient(
        name: name,
        contactIds: contactIds,
        contacts: contacts,
      );
      return Right(res);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> getAllContacts() async {
    try {
      final res = await addClientRemoteDataSource.getAllContacts();
      return Right(res);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
