part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadDataEvent extends HomeEvent {
  final CookieRequest request;

  const HomeLoadDataEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class HomeSearchEvent extends HomeEvent {
  final CookieRequest request;
  final String query;

  const HomeSearchEvent({required this.request, required this.query});

  @override
  List<Object> get props => [request, query];
}

class UpdateBookmarkedBooksEvent extends HomeEvent {
  final List<Book> bookmarkedBooks;

  const UpdateBookmarkedBooksEvent({required this.bookmarkedBooks});

  @override
  List<Object> get props => [bookmarkedBooks];
}

