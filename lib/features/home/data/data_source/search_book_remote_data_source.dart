import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ulas_buku_mobile/core/environments/endpoints.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';

class SearchBookRemoteDataSource {
  final CookieRequest request;

  SearchBookRemoteDataSource({required this.request});

  Future<List<Book>> searchBooks(String query) async {
    try {
      final List<Book> result = [];
      final response = await request.get('${EndPoints.search}?q=$query');

      // print(response);
      for (var i in response) {
        Book book = Book();
        book.model = 'main.book';
        book.pk = i['pk'];
        book.fields = Fields.fromJson(i);
        result.add(book);
      }

      return result;
    } catch (e) {
      throw Exception('error : $e');
    }
  }

}
