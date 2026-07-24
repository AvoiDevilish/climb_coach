class FormFieldDefinition {
  final String id;
  final String title;
  final String type;
  final bool required;
  final int order;

  const FormFieldDefinition({
    required this.id,
    required this.title,
    required this.type,
    required this.required,
    required this.order,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'required': required ? 1 : 0,
      'order': order,
    };
  }

  factory FormFieldDefinition.fromMap(
      Map<String, dynamic> map) {
    return FormFieldDefinition(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      required: map['required'] == 1,
      order: map['order'],
    );
  }
}
