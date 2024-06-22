import 'package:binary_city/core/common/entities/contact_entity.dart';
import 'package:binary_city/core/error/failures.dart';
import 'package:binary_city/core/usecase/usecase.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

import '../repository/contact_view_repo.dart';

final class GetAllContactsUseCase
    implements UseCase<List<ContactEntity>, NoParams> {
  final ContactViewRepository contactViewRepository;

  GetAllContactsUseCase(this.contactViewRepository);
  @override
  Future<Either<Failure, List<ContactEntity>>> call(params) async {
    return await contactViewRepository.getAllContacts();
  }
}
