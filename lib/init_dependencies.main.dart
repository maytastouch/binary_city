part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabase_service_role,
  );
  _addClientBloc();
  _clientViewBloc();
  _createFormBloc();
  _contactViewBloc();

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _addClientBloc() {
  //datasource
  serviceLocator
    ..registerFactory<AddClientRemoteDataSource>(
      () => AddClientRemoteDatasourceImpl(
        serviceLocator(),
      ),
    )

    //repository
    ..registerFactory<AddClientRepository>(
      () => AddClientRepositoryImpl(
        serviceLocator(),
      ),
    )

    //usecase
    ..registerFactory<AddClientUseCase>(
      () => AddClientUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory<GetAllContactUseCase>(
      () => GetAllContactUseCase(
        serviceLocator(),
      ),
    )

    //bloc
    ..registerLazySingleton(
      () => AddClientBloc(
        addClientUseCase: serviceLocator(),
        getAllContactsUseCase: serviceLocator(),
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

_createFormBloc() {
  //datasource
  serviceLocator.registerFactory<ContactFormRemoteDataSource>(
    () => ContactFormRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  //repository
  serviceLocator.registerFactory<ContactFormRepository>(
    () => ContactFormRepositoryImpl(
      serviceLocator(),
    ),
  );

  //usecase
  serviceLocator.registerFactory<CreateContactUseCase>(
    () => CreateContactUseCase(
      serviceLocator(),
    ),
  );

  //bloc
  serviceLocator.registerLazySingleton(
    () => CreateFormBloc(
      createContactUseCase: serviceLocator(),
    ),
  );
}

void _contactViewBloc() {
  //datasource
  serviceLocator.registerFactory<ContactViewRemoteDataSource>(
    () => ContactViewRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  //repository
  serviceLocator.registerFactory<ContactViewRepository>(
    () => ContactViewRepositoryImpl(
      serviceLocator(),
    ),
  );

  //usecase
  serviceLocator.registerFactory<GetAllContactsUseCase>(
    () => GetAllContactsUseCase(
      serviceLocator(),
    ),
  );

  //bloc
  serviceLocator.registerLazySingleton(
    () => ContactViewBloc(
      getAllContactsUseCase: serviceLocator(),
    ),
  );
}
