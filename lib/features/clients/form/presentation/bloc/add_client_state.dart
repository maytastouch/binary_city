part of 'add_client_bloc.dart';

@immutable
sealed class AddClientState {}

final class AddClientInitial extends AddClientState {}

final class AddClientLoading extends AddClientState {}

final class AddClientSuccess extends AddClientState {
  final String message;

  AddClientSuccess({required this.message});
}

final class AddClientFailure extends AddClientState {
  final String message;

  AddClientFailure({required this.message});
}
