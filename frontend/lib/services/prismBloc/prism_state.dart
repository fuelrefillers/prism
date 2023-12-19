part of 'prism_bloc.dart';

@immutable
abstract class PrismState {}

class PrismInitial extends PrismState {}

class UserFetchingLoadingState extends PrismState {}

class UserFetchingSuccessfullState extends PrismState {
  final User user;
  UserFetchingSuccessfullState({required this.user});
}

class UserFetchingErrorState extends PrismState {}

class BooksFetchingLoadingState extends PrismState {}

class BooksFetchingSuccessfullState extends PrismState {
  final List<Books> books;
  BooksFetchingSuccessfullState({required this.books});
}

class BooksFetchingErrorState extends PrismState {}

class BusFetchingLoadingState extends PrismState {}

class BusFetchingSuccessfullState extends PrismState {
  final List<Bus> busses;
  BusFetchingSuccessfullState({required this.busses});
}

class BusFetchingErrorState extends PrismState {}

// class FetchingLoadingState extends PrismState {}

// class UserFetchingSuccessfullState extends PrismState {}

// class UserFetchingErrorState extends PrismState {}

class FacultyFetchingLoadingState extends PrismState {}

class FacultyFetchingSuccessfullState extends PrismState {
  final Faculty faculty;
  FacultyFetchingSuccessfullState({required this.faculty});
}

class FacultyErrorState extends PrismState {}
