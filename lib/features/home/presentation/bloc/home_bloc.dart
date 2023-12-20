import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ulas_buku_mobile/features/home/data/data_source/book_list_remote_data_source.dart';
import 'package:ulas_buku_mobile/features/home/data/data_source/search_book_remote_data_source.dart';
import 'package:ulas_buku_mobile/features/home/data/data_source/sort_books_remote_data_source.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeLoadDataEvent>(_getBookList);
    on<HomeSearchEvent>(_searchBook);
    on<UpdateBookmarkedBooksEvent>(_updateBookmarkedBooks);
  }

  void _getBookList(
    HomeLoadDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());
      BookListRemoteDataSource dataSource =
          BookListRemoteDataSource(request: event.request);
      SortBooksRemoteDataSource sortDataSource =
          SortBooksRemoteDataSource(request: event.request);

      List<Book> allBooks = await dataSource.fetchBooks();
      List<Book> mostReviewedBook =
          await sortDataSource.fetchSortedBooks('reviews-count');
      List<Book> byPrefBooks =
          await sortDataSource.fetchSortedBooks('preference');

      emit(
        HomeLoaded(
            allBooks: allBooks,
            mostReviewedBooks: mostReviewedBook,
            byPrefBooks: byPrefBooks),
      );
    } catch (e) {
      emit(
        HomeError(
          message: e.toString(),
        ),
      );
    }
  }

  void _searchBook(
    HomeSearchEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeSearchLoading());
      SearchBookRemoteDataSource dataSource =
          SearchBookRemoteDataSource(request: event.request);

      List<Book> books = await dataSource.searchBooks(event.query);

      emit(
        HomeSearchLoaded(results: books),
      );
    } catch (e) {
      emit(
        HomeError(
          message: e.toString(),
        ),
      );
    }
  }

  void _updateBookmarkedBooks(
    UpdateBookmarkedBooksEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeBookmarkedBooksUpdated(bookmarkedBooks: event.bookmarkedBooks));
  }
}
