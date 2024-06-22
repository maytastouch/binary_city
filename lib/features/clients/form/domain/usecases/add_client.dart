import 'package:binary_city/core/error/failures.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../../../../../core/usecase/usecase.dart';
import '../repository/add_client_repo.dart';

class AddClientUseCase implements UseCase<String, AddClientParams> {
  final AddClientRepository repository;

  AddClientUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call(AddClientParams params) async {
    return repository.addClient(
      name: params.name,
      contactIds: params.contactIds,
      contacts: params.contacts,
    );
  }
}

class AddClientParams {
  final String name;
  final List<String> contactIds;
  final List<String> contacts;

  AddClientParams({
    required this.name,
    required this.contactIds,
    required this.contacts,
  });
}
