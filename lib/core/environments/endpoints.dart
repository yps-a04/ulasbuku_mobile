class EndPoints {
  //kalo pake emulator gini kalo engga pake link local yang django
  static const String baseUrl = 'https://ulasbuku-a04-tk.pbp.cs.ui.ac.id';

  static const String login = '$baseUrl/auth/login/';
  static const String logout = '$baseUrl/auth/logout/';
  static const String getAllBooks = '$baseUrl/books-json/';
  static const String search = '$baseUrl/search/';
  static const String sort = "$baseUrl/sort-books";
  static const String getUserBookmark = "$baseUrl/bookmarks-json/";
}
