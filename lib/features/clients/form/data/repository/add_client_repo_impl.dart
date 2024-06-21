import 'package:binary_city/core/error/exceptions.dart';
import 'package:binary_city/core/error/failures.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../../domain/repository/add_client_repo.dart';
import '../datasources/add_client_remote_datasource.dart';

class AddClientRepositoryImpl implements AddClientRepository {
  final AddClientRemoteDataSource addClientRemoteDataSource;

  AddClientRepositoryImpl(this.addClientRemoteDataSource);
  @override
  Future<Either<Failure, String>> addClient({required String name}) async {
    try {
      final res = await addClientRemoteDataSource.addClient(name: name);
      return  Right(res);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
