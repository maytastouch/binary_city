import 'package:binary_city/core/common/entities/client_entity.dart';
import 'package:binary_city/core/error/exceptions.dart';

import 'package:binary_city/core/error/failures.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../../domain/repository/client_view_repo.dart';
import '../datasources/client_view_remote_datasource.dart';

class ClientViewRepositoryImpl implements ClientViewRepository {
  final ClientViewRemoteDataSource clientViewRemoteDataSource;

  ClientViewRepositoryImpl(this.clientViewRemoteDataSource);

  @override
  Future<Either<Failure, List<ClientEntity>>> getClients() async {
    try {
      final clientList = await clientViewRemoteDataSource.getClients();
      return Right(clientList);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
