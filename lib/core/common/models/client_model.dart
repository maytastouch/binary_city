import 'package:binary_city/core/common/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  ClientModel({
    required super.name,
    required super.clientCode,
    required super.numberOfLinkedContacts,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      name: json['name'],
      clientCode: json['client_code'],
      numberOfLinkedContacts: json['number_of_linked_contacts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'client_code': clientCode,
      'number_of_linked_contacts': numberOfLinkedContacts,
    };
  }

  ClientModel copyWith({
    String? name,
    String? clientCode,
    int? numberOfLinkedContacts,
  }) {
    return ClientModel(
      name: name ?? this.name,
      clientCode: clientCode ?? this.clientCode,
      numberOfLinkedContacts:
          numberOfLinkedContacts ?? this.numberOfLinkedContacts,
    );
  }
}
