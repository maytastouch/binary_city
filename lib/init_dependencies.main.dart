part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabase_service_role,
  );
  _addClientBloc();
  _clientViewBloc();

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _addClientBloc() {
  //datasource
  serviceLocator.registerFactory<AddClientRemoteDataSource>(
    () => AddClientRemoteDatasourceImpl(
      serviceLocator(),
    ),
  );

  //repository
  serviceLocator.registerFactory<AddClientRepository>(
    () => AddClientRepositoryImpl(
      serviceLocator(),
    ),
  );

  //usecase
  serviceLocator.registerFactory<AddClientUseCase>(
    () => AddClientUseCase(
      serviceLocator(),
    ),
  );

  //bloc
  serviceLocator.registerLazySingleton(
    () => AddClientBloc(
      addClientUseCase: serviceLocator(),
    ),
  );
}

_clientViewBloc() {
  //datasource
  serviceLocator.registerFactory<ClientViewRemoteDataSource>(
    () => ClientViewRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  //repository
  serviceLocator.registerFactory<ClientViewRepository>(
    () => ClientViewRepositoryImpl(
      serviceLocator(),
    ),
  );

  //usecase
  serviceLocator.registerFactory<GetClientsUseCase>(
    () => GetClientsUseCase(
      serviceLocator(),
    ),
  );

  //bloc
  serviceLocator.registerLazySingleton(
    () => ClientViewBloc(
      getClientUseCase: serviceLocator(),
    ),
  );
}
