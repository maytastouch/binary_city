part of 'create_form_bloc.dart';

@immutable
sealed class CreateFormEvent {}

final class CreateContactEvent extends CreateFormEvent {
  final String firstName;
  final String lastName;
  final String email;

  CreateContactEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}
