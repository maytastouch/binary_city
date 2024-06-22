import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/entities/client_entity.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_clients.dart';

part 'client_view_event.dart';
part 'client_view_state.dart';

class ClientViewBloc extends Bloc<ClientViewEvent, ClientViewState> {
  static List<ClientEntity> allClients = [];

  final GetClientsUseCase _getClientUseCase;
  ClientViewBloc({required GetClientsUseCase getClientUseCase})
      : _getClientUseCase = getClientUseCase,
        super(ClientViewInitial()) {
    on<GetClientsEvent>(_onGetClientsEvent);
  }

  Future<void> _onGetClientsEvent(
    GetClientsEvent event,
    Emitter<ClientViewState> emit,
  ) async {
    emit(GetClientsLoading());
    final result = await _getClientUseCase(NoParams());
    result.fold(
      (failure) => emit(GetClientsFailure(failure.message)),
      (clients) {
        emit(GetClientsSuccess(clients));
        allClients = clients;
      },
    );
  }
}
