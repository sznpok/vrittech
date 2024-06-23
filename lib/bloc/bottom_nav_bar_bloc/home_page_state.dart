part of 'home_page_bloc.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class Page1 extends HomePageState {}

final class Page2 extends HomePageState {}

final class Page3 extends HomePageState {}
