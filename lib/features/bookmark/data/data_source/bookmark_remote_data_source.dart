import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ulas_buku_mobile/core/environments/endpoints.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';

class BookmarkListRemoteDataSource {
  final CookieRequest request;

  BookmarkListRemoteDataSource({required this.request});

  Future<List<Book>> fetchBooks() async {
    try {
      final List<Book> result = [];
      final response = await request.get(EndPoints.getUserBookmark);

      // print(response);
      for (var i in response) {
        Book book = Book.fromJson(i); 
        result.add(book);
      }

      return result;
    } catch (e) {
      throw Exception('error : $e');
    }
  }
}
