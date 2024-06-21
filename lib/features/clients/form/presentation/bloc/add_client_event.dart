part of 'add_client_bloc.dart';

@immutable
sealed class AddClientEvent {}

final class AddClientsEvent extends AddClientEvent {
  final String name;

  AddClientsEvent({required this.name});
}
