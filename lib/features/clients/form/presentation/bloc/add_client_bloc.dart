import 'package:binary_city/features/clients/form/domain/usecases/add_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_client_event.dart';
part 'add_client_state.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  final AddClientUseCase _addClientUseCase;

  AddClientBloc({required AddClientUseCase addClientUseCase})
      : _addClientUseCase = addClientUseCase,
        super(AddClientInitial()) {
    on<AddClientsEvent>(_onAddClientsEvent);
  }

  Future<void> _onAddClientsEvent(
    AddClientsEvent event,
    Emitter<AddClientState> emit,
  ) async {
    emit(AddClientLoading());
    final result = await _addClientUseCase(AddClientParams(name: event.name));
    result.fold(
      (failure) => emit(AddClientFailure(message: failure.message)),
      (res) => emit(
          AddClientSuccess(message: 'Client added successfully', code: res)),
    );
  }
}
