import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failures.dart';

abstract interface class AddClientRepository {
  // add client to database
  Future<Either<Failure, void>> addClient({
    required String name,
  });
}
