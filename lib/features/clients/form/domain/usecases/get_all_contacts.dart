import 'package:binary_city/core/error/failures.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../../../../../core/common/entities/contact_entity.dart';
import '../../../../../core/usecase/usecase.dart';
import '../repository/add_client_repo.dart';

class GetAllContactUseCase implements UseCase<List<ContactEntity>, NoParams> {
  final AddClientRepository addClientRepository;

  GetAllContactUseCase(this.addClientRepository);
  @override
  Future<Either<Failure, List<ContactEntity>>> call(NoParams params) async {
    return addClientRepository.getAllContacts();
  }
}
