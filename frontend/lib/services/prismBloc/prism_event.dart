part of 'prism_bloc.dart';

@immutable
abstract class PrismEvent {}

class UserInitialFetchEvent extends PrismEvent {}

class BooksInitialFetchEvent extends PrismEvent {
  final String category;
  BooksInitialFetchEvent({required this.category});
}

class BussesInitialFetchEvent extends PrismEvent {}
