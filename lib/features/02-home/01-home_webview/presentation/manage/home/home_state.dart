part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ReturnSocialLinks extends HomeState {
  final List<SocialWebViewItem> items;

  ReturnSocialLinks(this.items);
}
