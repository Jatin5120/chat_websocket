import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
  });

  factory UserModel.fromMap(
    Map<String, dynamic> map,
  ) =>
      UserModel(
        id: map['id'] as String? ?? '',
        email: map['email'] as String? ?? '',
        name: map['name'] as String? ?? '',
        password: map['password'] as String? ?? '',
      );

  factory UserModel.fromJson(
    String source,
  ) =>
      UserModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String password;

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? password,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'email': email,
        'name': name,
        'password': password,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'UserModel(id: $id, email: $email, name: $name, password: $password)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email && other.name == name && other.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ name.hashCode ^ password.hashCode;
}
