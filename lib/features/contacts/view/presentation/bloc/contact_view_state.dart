part of 'contact_view_bloc.dart';

@immutable
sealed class ContactViewState {}

final class ContactViewInitial extends ContactViewState {}

final class GetAllContactsLoading extends ContactViewState {}

final class GetAllContactsLoaded extends ContactViewState {
  final List<ContactEntity> contactList;

  GetAllContactsLoaded(this.contactList);
}

final class GetAllContactsError extends ContactViewState {
  final String message;

  GetAllContactsError(this.message);
}
