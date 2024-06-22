class ClientEntity {
  final String name;
  final String clientCode;
  int numberOfLinkedContacts;
  final String id;

  ClientEntity({
    required this.name,
    required this.clientCode,
    required this.numberOfLinkedContacts,
    required this.id,
  });
}
