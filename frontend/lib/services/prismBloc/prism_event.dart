part of 'prism_bloc.dart';

@immutable
abstract class PrismEvent {}

class UserInitialFetchEvent extends PrismEvent {}

class BussesInitialFetchEvent extends PrismEvent {}

class FacultyInitialFetchEvent extends PrismEvent {}

class TimeTableInitialFetchEvent extends PrismEvent {}
