import 'package:binary_city/features/contacts/view/domain/usecases/get_all_contacts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/entities/contact_entity.dart';
import '../../../../../core/usecase/usecase.dart';

part 'contact_view_event.dart';
part 'contact_view_state.dart';

class ContactViewBloc extends Bloc<ContactViewEvent, ContactViewState> {
  final GetAllContactsUseCase _getAllContactsUseCase;
  static List<ContactEntity> allContactList = [];
  ContactViewBloc({required GetAllContactsUseCase getAllContactsUseCase})
      : _getAllContactsUseCase = getAllContactsUseCase,
        super(ContactViewInitial()) {
    on<GetAllContactsEvent>(_getAllStudents);
  }

  void _getAllStudents(
    GetAllContactsEvent event,
    Emitter<ContactViewState> emit,
  ) async {
    emit(GetAllContactsLoading());
    final result = await _getAllContactsUseCase(NoParams());
    result.fold(
      (failure) => emit(GetAllContactsError(failure.message)),
      (contactList) {
        allContactList = contactList;
        emit(GetAllContactsLoaded(contactList));
      },
    );
  }
}
