import 'package:binary_city/core/common/models/client_model.dart';
import 'package:binary_city/core/constants/constants.dart';
import 'package:binary_city/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ClientViewRemoteDataSource {
  Future<List<ClientModel>> getClients();
}

class ClientViewRemoteDataSourceImpl implements ClientViewRemoteDataSource {
  final SupabaseClient supabaseClient;

  ClientViewRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<List<ClientModel>> getClients() async {
    try {
      final clientList =
          await supabaseClient.from(AppConstants.clientStable).select('*');
      return clientList.map((client) => ClientModel.fromJson(client)).toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
