part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<Book> books;

  const HomeLoaded({required this.books});

  @override
  List<Object> get props => [books];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

final class HomeSearchLoading extends HomeState {}

final class HomeSearchLoaded extends HomeState {
  final List<Book> results;

  const HomeSearchLoaded({required this.results});

  @override
  List<Object> get props => [results];
}

final class HomeSearchError extends HomeState {}
