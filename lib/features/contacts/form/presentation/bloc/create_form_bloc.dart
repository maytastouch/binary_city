import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/create_contact.dart';

part 'create_form_event.dart';
part 'create_form_state.dart';

class CreateFormBloc extends Bloc<CreateFormEvent, CreateFormState> {
  final CreateContactUseCase _createContactUseCase;
  CreateFormBloc({required CreateContactUseCase createContactUseCase})
      : _createContactUseCase = createContactUseCase,
        super(CreateFormInitial()) {
    on<CreateContactEvent>(_createContact);
  }

  void _createContact(
    CreateContactEvent event,
    Emitter<CreateFormState> emit,
  ) async {
    emit(CreateFormLoading());
    final result = await _createContactUseCase.call(CreateContactParams(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
    ));
    result.fold(
      (failure) => emit(CreateFormFailure(message: failure.message)),
      (_) => emit(CreateFormSuccess(message: 'Contact created successfully')),
    );
  }
}
