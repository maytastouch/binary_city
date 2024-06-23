import 'package:binary_city/core/common/entities/client_contact_entity.dart';

class ClientContactModel extends ClientContactEntity {
  ClientContactModel({
    required super.clientId,
    required super.contactId,
    required super.id,
  });

  factory ClientContactModel.fromJson(Map<String, dynamic> json) {
    return ClientContactModel(
      clientId: json['client_id'] as String,
      contactId: json['contact_id'] as String,
      id: json['id'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'contact_id': contactId,
      'id': id,
    };
  }
}
