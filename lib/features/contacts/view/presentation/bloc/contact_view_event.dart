part of 'contact_view_bloc.dart';

@immutable
sealed class ContactViewEvent {}

final class GetAllContactsEvent extends ContactViewEvent {}
