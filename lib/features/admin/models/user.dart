// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

class User {
    int id;
    String username;
    String dateJoined;
    String lastLogin;

    User({
        required this.id,
        required this.username,
        required this.dateJoined,
        required this.lastLogin,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        dateJoined: json["date_joined"].toString(),
        lastLogin: json["last_login"].toString(),
    );
}
