import 'package:binary_city/core/common/entities/client_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../repository/client_view_repo.dart';

class GetClientsUseCase implements UseCase<List<ClientEntity>, NoParams> {
  final ClientViewRepository repository;

  GetClientsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ClientEntity>>> call(NoParams params) async {
    return await repository.getClients();
  }
}
