
class DataModel {
  int? id;
  String name;
  int age;
  String email;
  String password;

  DataModel({
    this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'password': password,
    };
  }

  static DataModel fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      email: map['email'],
      password: map['password'],
    );
  }
}
