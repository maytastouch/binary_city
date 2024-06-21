import 'package:binary_city/core/error/failures.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../../../../../core/usecase/usecase.dart';
import '../repository/add_client_repo.dart';

class AddClientUseCase implements UseCase<void, AddClientParams> {
  final AddClientRepository repository;

  AddClientUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(AddClientParams params) async {
    return repository.addClient(name: params.name);
  }
}

class AddClientParams {
  final String name;

  AddClientParams({required this.name});
}
