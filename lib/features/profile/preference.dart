// To parse this JSON data, do
//
//     final preference = preferenceFromJson(jsonString);

import 'dart:convert';

List<Preference> preferenceFromJson(String str) => List<Preference>.from(json.decode(str).map((x) => Preference.fromJson(x)));

String preferenceToJson(List<Preference> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Preference {
    String model;
    int pk;
    Fields fields;

    Preference({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Preference.fromJson(Map<String, dynamic> json) => Preference(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String author;

    Fields({
        required this.user,
        required this.author,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "author": author,
    };
}
