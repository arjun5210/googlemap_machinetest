part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchSites extends HomeEvent {}

class getproducts extends HomeEvent {}

class getfooddetails extends HomeEvent {}

class getfooddata extends HomeEvent {
  String id;
  getfooddata({required this.id});
}
