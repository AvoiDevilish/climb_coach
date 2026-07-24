class Athlete {
  final int? id;

  final String firstName;
  final String lastName;

  final int? age;
  final double? height;
  final double? weight;

  final String? gender;

  Athlete({
    this.id,
    required this.firstName,
    required this.lastName,
    this.age,
    this.height,
    this.weight,
    this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
    };
  }

  factory Athlete.fromMap(Map<String, dynamic> map) {
    return Athlete(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      age: map['age'],
      height: map['height']?.toDouble(),
      weight: map['weight']?.toDouble(),
      gender: map['gender'],
    );
  }
}
