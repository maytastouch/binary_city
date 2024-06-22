part of 'add_client_bloc.dart';

@immutable
sealed class AddClientState {}

final class AddClientInitial extends AddClientState {}

final class AddClientLoading extends AddClientState {}

final class AddClientSuccess extends AddClientState {
  final String message;
  final String code;
  final int numberOfLinkedContacts;

  AddClientSuccess({
    required this.numberOfLinkedContacts,
    required this.message,
    required this.code,
  });
}

final class AddClientFailure extends AddClientState {
  final String message;

  AddClientFailure({required this.message});
}

final class GetAllContactsLoaded extends AddClientState {
  final List<ContactEntity> contacts;

  GetAllContactsLoaded({required this.contacts});
}

final class GetAllContactsFailed extends AddClientState {
  final String message;

  GetAllContactsFailed({required this.message});
}
