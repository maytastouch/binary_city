part of 'client_view_bloc.dart';

@immutable
sealed class ClientViewState {}

final class ClientViewInitial extends ClientViewState {}

final class GetClientsLoading extends ClientViewState {}

final class GetClientsSuccess extends ClientViewState {
  final List<ClientEntity> clients;

  GetClientsSuccess(this.clients);
}

final class GetClientsFailure extends ClientViewState {
  final String message;

  GetClientsFailure(this.message);
}
