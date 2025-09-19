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
