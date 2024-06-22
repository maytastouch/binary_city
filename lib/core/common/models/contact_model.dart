import 'package:binary_city/core/common/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.id,
    //required super.numberOfLinkedClients,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      id: json['contacts_id'],
      //numberOfLinkedClients: json['number_of_linked_clients'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'contacts_id': id,
      // 'number_of_linked_clients': numberOfLinkedClients,
    };
  }

  ContactModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? id,
    //int? numberOfLinkedClients,
  }) {
    return ContactModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      id: id ?? this.id,
      //numberOfLinkedClients:
      //    numberOfLinkedClients ?? this.numberOfLinkedClients,
    );
  }
}
