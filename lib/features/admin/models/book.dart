// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    int pk;
    String title;
    String author;
    double averageRating;
    String isbn;
    String isbn13;
    LanguageCode languageCode;
    int numPages;
    int ratingCount;
    int textReviewCount;
    dynamic publicationDate;
    String publisher;

    Book({
        required this.pk,
        required this.title,
        required this.author,
        required this.averageRating,
        required this.isbn,
        required this.isbn13,
        required this.languageCode,
        required this.numPages,
        required this.ratingCount,
        required this.textReviewCount,
        required this.publicationDate,
        required this.publisher,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        pk: json["pk"],
        title: json["title"],
        author: json["author"],
        averageRating: json["average_rating"]?.toDouble(),
        isbn: json["isbn"],
        isbn13: json["isbn13"],
        languageCode: languageCodeValues.map[json["language_code"]]!,
        numPages: json["num_pages"],
        ratingCount: json["rating_count"],
        textReviewCount: json["text_review_count"],
        publicationDate: json["publication_date"],
        publisher: json["publisher"],
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "title": title,
        "author": author,
        "average_rating": averageRating,
        "isbn": isbn,
        "isbn13": isbn13,
        "language_code": languageCodeValues.reverse[languageCode],
        "num_pages": numPages,
        "rating_count": ratingCount,
        "text_review_count": textReviewCount,
        "publication_date": publicationDate,
        "publisher": publisher,
    };
}

enum LanguageCode {
    ENG,
    EN_GB,
    EN_US,
    JPN
}

final languageCodeValues = EnumValues({
    "eng": LanguageCode.ENG,
    "en-GB": LanguageCode.EN_GB,
    "en-US": LanguageCode.EN_US,
    "jpn": LanguageCode.JPN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
