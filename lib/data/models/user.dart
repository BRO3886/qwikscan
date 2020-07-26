// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.message,
    this.token,
    this.user,
  });

  String message;
  String token;
  UserClass user;

  factory User.fromJson(Map<String, dynamic> json) => User(
        message: json["message"],
        token: json["token"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user.toJson(),
      };
}

class UserClass {
  UserClass({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.name,
    this.email,
    this.password,
    this.imageUrl,
    this.phoneNumber,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String userId;
  String name;
  String email;
  String password;
  String imageUrl;
  String phoneNumber;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["ID"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        deletedAt: json["DeletedAt"],
        userId: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        imageUrl: json["image_url"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "DeletedAt": deletedAt,
        "id": userId,
        "name": name,
        "email": email,
        "password": password,
        "image_url": imageUrl,
        "phone_number": phoneNumber,
      };
}
