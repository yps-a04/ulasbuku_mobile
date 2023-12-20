class Book {
  String? model;
  int? pk;
  Fields? fields;

  Book({this.model, this.pk, this.fields});

  Book.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields =
        json['fields'] != null ?  Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    data['pk'] = pk;
    if (fields != null) {
      data['fields'] = fields!.toJson();
    }
    return data;
  }
}

class Fields {
  String? title;
  String? author;
  double? averageRating;
  String? isbn;
  String? isbn13;
  String? languageCode;
  int? numPages;
  int? ratingCount;
  int? textReviewCount;
  String? publicationDate;
  String? publisher;
  bool? isBookmarked;

  Fields(
      {this.title,
      this.author,
      this.averageRating,
      this.isbn,
      this.isbn13,
      this.languageCode,
      this.numPages,
      this.ratingCount,
      this.textReviewCount,
      this.publicationDate,
      this.publisher,
      this.isBookmarked});

  Fields.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    averageRating = json['average_rating'];
    isbn = json['isbn'];
    isbn13 = json['isbn13'];
    languageCode = json['language_code'];
    numPages = json['num_pages'];
    ratingCount = json['rating_count'];
    textReviewCount = json['text_review_count'];
    publicationDate = json['publication_date'];
    publisher = json['publisher'];
    isBookmarked = json['isBookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['author'] = author;
    data['average_rating'] = averageRating;
    data['isbn'] = isbn;
    data['isbn13'] = isbn13;
    data['language_code'] = languageCode;
    data['num_pages'] = numPages;
    data['rating_count'] = ratingCount;
    data['text_review_count'] = textReviewCount;
    data['publication_date'] = publicationDate;
    data['publisher'] = publisher;
    return data;
  }
}
