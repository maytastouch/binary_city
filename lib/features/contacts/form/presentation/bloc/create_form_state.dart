part of 'create_form_bloc.dart';

@immutable
sealed class CreateFormState {}

final class CreateFormInitial extends CreateFormState {}

final class CreateFormLoading extends CreateFormState {}

final class CreateFormSuccess extends CreateFormState {
  final String message;

  CreateFormSuccess({required this.message});
}

final class CreateFormFailure extends CreateFormState {
  final String message;

  CreateFormFailure({required this.message});
}
