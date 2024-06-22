import 'package:binary_city/features/clients/form/domain/usecases/add_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/entities/contact_entity.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_all_contacts.dart';

part 'add_client_event.dart';
part 'add_client_state.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  final AddClientUseCase _addClientUseCase;
  final GetAllContactUseCase _getAllContactsUseCase;

  static List<ContactEntity> allContacts = [];
  AddClientBloc(
      {required AddClientUseCase addClientUseCase,
      required GetAllContactUseCase getAllContactsUseCase})
      : _addClientUseCase = addClientUseCase,
        _getAllContactsUseCase = getAllContactsUseCase,
        super(AddClientInitial()) {
    on<AddClientsEvent>(_onAddClientsEvent);
    on<GetAllContactEvent>(_getAllContacts);
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

  void _getAllContacts(
    GetAllContactEvent event,
    Emitter<AddClientState> emit,
  ) async {
    //emit(AddClientLoading());
    final result = await _getAllContactsUseCase(NoParams());
    result
        .fold((failure) => emit(GetAllContactsFailed(message: failure.message)),
            (res) {
      allContacts = res;
      emit(GetAllContactsLoaded(contacts: res));
    });
  }
}
