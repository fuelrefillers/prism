import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/models/faculty_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/repo.dart';

part 'prism_event.dart';
part 'prism_state.dart';

class PrismBloc extends Bloc<PrismEvent, PrismState> {
  PrismBloc() : super(PrismInitial()) {
    on<UserInitialFetchEvent>(userInitialFetchEvent);
    on<FacultyInitialFetchEvent>(facultyInitialFetchEvent);
  }

  FutureOr<void> userInitialFetchEvent(
      UserInitialFetchEvent event, Emitter<PrismState> emit) async {
    emit(UserFetchingLoadingState());
    await Future.delayed(Duration(seconds: 2));
    User user = await PrismRepo.getUser();
    emit(UserFetchingSuccessfullState(user: user));
  }

  FutureOr<void> facultyInitialFetchEvent(
      FacultyInitialFetchEvent event, Emitter<PrismState> emit) async {
    emit(FacultyFetchingLoadingState());
    await Future.delayed(Duration(seconds: 2));
    Faculty faculty = await PrismRepo.getFaculty();
    emit(FacultyFetchingSuccessfullState(faculty: faculty));
  }
}
