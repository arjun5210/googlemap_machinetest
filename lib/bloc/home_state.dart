part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class SiteLoading extends HomeState {}

class SiteLoaded extends HomeState {
  final List<Site> sites;
  SiteLoaded(this.sites);
}

class SiteError extends HomeState {
  final String message;
  SiteError(this.message);
}

class getloading extends HomeState {}

class geterror extends HomeState {
  String error;
  geterror({required this.error});
}

class getloaded extends HomeState {
  List<productdetails> data;

  getloaded({required this.data});
}

class foodloading extends HomeState {}

class foodloaded extends HomeState {
  List<fooddetails> details;
  foodloaded({required this.details});
}

class fooddetailsloaded extends HomeState {
  List<fooddetailsmodel> details;
  fooddetailsloaded({required this.details});
}

class foodderror extends HomeState {
  String error;
  foodderror({required this.error});
}
