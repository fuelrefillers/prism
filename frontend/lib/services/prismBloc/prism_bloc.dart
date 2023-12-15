import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/repo.dart';

part 'prism_event.dart';
part 'prism_state.dart';

class PrismBloc extends Bloc<PrismEvent, PrismState> {
  PrismBloc() : super(PrismInitial()) {
    on<UserInitialFetchEvent>(userInitialFetchEvent);
    on<BussesInitialFetchEvent>(bussesInitialFetchEvent);
    on<BooksInitialFetchEvent>(booksInitialFetchEvent);
  }

  FutureOr<void> userInitialFetchEvent(
      UserInitialFetchEvent event, Emitter<PrismState> emit) async {
    emit(UserFetchingLoadingState());
    await Future.delayed(Duration(seconds: 2));
    User user = await PrismRepo.getUser();
    emit(UserFetchingSuccessfullState(user: user));
  }

  FutureOr<void> bussesInitialFetchEvent(
      BussesInitialFetchEvent event, Emitter<PrismState> emit) async {
    emit(BusFetchingLoadingState());
    await Future.delayed(Duration(milliseconds: 700));
    List<Bus> busses = await PrismRepo.getBusses();
    emit(BusFetchingSuccessfullState(busses: busses));
  }

  FutureOr<void> booksInitialFetchEvent(
      BooksInitialFetchEvent event, Emitter<PrismState> emit) async {
    emit(BooksFetchingLoadingState());
    await Future.delayed(Duration(milliseconds: 700));
    List<Books> books = await PrismRepo.getbooks();
    emit(BooksFetchingSuccessfullState(books: books));
  }
}
