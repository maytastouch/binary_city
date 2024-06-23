part of 'add_client_bloc.dart';

@immutable
sealed class AddClientEvent {}

final class AddClientsEvent extends AddClientEvent {
  final String name;
  final List<String> contactIds;
  final List<String> contacts;

  AddClientsEvent({
    required this.name,
    required this.contactIds,
    required this.contacts,
  });
}

final class GetAllContactEvent extends AddClientEvent {}
