class User {
  final String name;
  final String surname;
  final int age;

  User({required this.name, required this.surname, required this.age});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['age'] = age;
    return data;
  }
}
