import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ulas_buku_mobile/features/home/data/data_source/book_list_remote_data_source.dart';
import 'package:ulas_buku_mobile/features/home/data/data_source/search_book_remote_data_source.dart';
import 'package:ulas_buku_mobile/features/home/data/models/book.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeLoadDataEvent>(_getBookList);
    on<HomeSearchEvent>(_searchBook);
  }

  void _getBookList(
    HomeLoadDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());
      BookListRemoteDataSource dataSource =
          BookListRemoteDataSource(request: event.request);

      List<Book> books = await dataSource.fetchBooks();

      emit(
        HomeLoaded(books: books),
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
}
