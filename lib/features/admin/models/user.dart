// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    int id;
    String username;
    DateTime dateJoined;
    DateTime lastLogin;

    User({
        required this.id,
        required this.username,
        required this.dateJoined,
        required this.lastLogin,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        dateJoined: DateTime.parse(json["date_joined"]),
        lastLogin: DateTime.parse(json["last_login"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "date_joined": dateJoined.toIso8601String(),
        "last_login": lastLogin.toIso8601String(),
    };
}
