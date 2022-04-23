part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetHomeSuccessState extends HomeState {
  final List<Home> dataHome;

  GetHomeSuccessState(this.dataHome);
}

class GetHomeFailedState extends HomeState {
  final String message;

  GetHomeFailedState({this.message = ''});
}

class GetFailureState extends HomeState {
  final String error;

  GetFailureState(this.error);
}

class LoadingState extends HomeState {}
