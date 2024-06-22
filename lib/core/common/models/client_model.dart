import 'package:binary_city/core/common/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  ClientModel({
    required super.name,
    required super.clientCode,
    required super.numberOfLinkedContacts,
    required super.id,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      name: json['name'] as String,
      clientCode: json['client_code'] as String,
      numberOfLinkedContacts: json['number_of_linked_contacts'] ?? 0,
      id: json['client_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'client_code': clientCode,
      'number_of_linked_contacts': numberOfLinkedContacts,
      'client_id': id,
    };
  }

  ClientModel copyWith({
    String? name,
    String? clientCode,
    int? numberOfLinkedContacts,
    String? id,
  }) {
    return ClientModel(
      name: name ?? this.name,
      clientCode: clientCode ?? this.clientCode,
      numberOfLinkedContacts:
          numberOfLinkedContacts ?? this.numberOfLinkedContacts,
      id: id ?? this.id,
    );
  }
}
