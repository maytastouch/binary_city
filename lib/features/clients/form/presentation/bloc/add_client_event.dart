part of 'add_client_bloc.dart';

@immutable
sealed class AddClientEvent {}

final class AddClientsEvent extends AddClientEvent {
  final String name;
  final List<String> contactIds;

  AddClientsEvent({
    required this.name,
    required this.contactIds,
  });
}

final class GetAllContactEvent extends AddClientEvent {}
