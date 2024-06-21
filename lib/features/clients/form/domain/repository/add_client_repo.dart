import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failures.dart';

abstract interface class AddClientRepository {
  // add client to database
  Future<Either<Failure, String>> addClient({
    required String name,
  });
}
