class EndPoints {
  //kalo pake emulator gini kalo engga pake link local yang django
  static const String baseUrl = 'http://127.0.0.1:8000/';
  static const String login = '$baseUrl/auth/login/';
  static const String logout = '$baseUrl/auth/logout/';
  static const String getAllBooks = '$baseUrl/books-json/';
  static const String search = '$baseUrl/search/';
}
