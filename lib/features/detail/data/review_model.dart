class Review {
  String? status;
  List<Data>? data;

  Review({this.status, this.data});

  Review.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? user;
  String? review;
  String? title;

  Data({this.user, this.review, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    review = json['review'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['review'] = review;
    data['title'] = title;
    return data;
  }
}
