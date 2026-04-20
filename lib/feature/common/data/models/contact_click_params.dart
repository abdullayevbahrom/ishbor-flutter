class ContactClickParams {
  final int id;
  final String type;
  final String contact;

  ContactClickParams({
    required this.id,
    required this.type,
    required this.contact,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'contact': contact,
    };
  }
}
