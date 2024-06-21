part of 'client_view_bloc.dart';

@immutable
sealed class ClientViewEvent {}

final class GetClientsEvent extends ClientViewEvent {}
