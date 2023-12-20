class EndPoints {
  //kalo pake emulator gini kalo engga pake link local yang django
  static const String baseUrl = 'https://ulasbuku-a04-tk.pbp.cs.ui.ac.id';
  //static const String baseUrl = 'http://10.0.2.2:8000';
  static const String login = '$baseUrl/auth/login/';
  static const String logout = '$baseUrl/auth/logout/';
  static const String getAllBooks = '$baseUrl/books-json';
  static const String search = '$baseUrl/search/';
  static const String getUser = '$baseUrl/show-admin/api/users/';
  static const String sort = "$baseUrl/sort-books";
  static const String getUserBookmark = "$baseUrl/bookmarks-json/";
  static const String addReview = '$baseUrl/add-review-flutter/';
  static const String getReview = '$baseUrl/show-review-flutter/';
  static const String register = '$baseUrl/auth/register/';
}
