import 'package:binary_city/core/error/failures.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../../../../../core/usecase/usecase.dart';
import '../repository/add_client_repo.dart';

class AddClientUseCase
    implements UseCase<Map<String, dynamic>, AddClientParams> {
  final AddClientRepository repository;

  AddClientUseCase(this.repository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      AddClientParams params) async {
    return repository.addClient(
      name: params.name,
      contactIds: params.contactIds,
    );
  }
}

class AddClientParams {
  final String name;
  final List<String> contactIds;

  AddClientParams({
    required this.name,
    required this.contactIds,
  });
}
