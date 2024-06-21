import 'package:binary_city/core/common/entities/client_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failures.dart';

abstract interface class ClientViewRepository {
  //get all clients
  Future<Either<Failure, List<ClientEntity>>> getClients();
}
