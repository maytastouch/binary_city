import 'package:binary_city/core/common/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.numberOfLinkedClients,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      numberOfLinkedClients: json['number_of_linked_clients'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'number_of_linked_clients': numberOfLinkedClients,
    };
  }

  ContactModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    int? numberOfLinkedClients,
  }) {
    return ContactModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      numberOfLinkedClients:
          numberOfLinkedClients ?? this.numberOfLinkedClients,
    );
  }
}
