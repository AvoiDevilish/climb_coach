class CustomField {
  final int? id;

  final String key;

  final String title;

  final String type;

  final bool requiredField;

  final int orderIndex;

  final bool active;

  const CustomField({
    this.id,
    required this.key,
    required this.title,
    required this.type,
    required this.requiredField,
    required this.orderIndex,
    required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'field_key': key,
      'title': title,
      'field_type': type,
      'required_field': requiredField ? 1 : 0,
      'order_index': orderIndex,
      'active': active ? 1 : 0,
    };
  }

  factory CustomField.fromMap(Map<String, dynamic> map) {
    return CustomField(
      id: map['id'],
      key: map['field_key'],
      title: map['title'],
      type: map['field_type'],
      requiredField: map['required_field'] == 1,
      orderIndex: map['order_index'],
      active: map['active'] == 1,
    );
  }
}
