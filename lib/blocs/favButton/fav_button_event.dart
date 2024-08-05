part of 'fav_button_bloc.dart';

sealed class FavButtonEvent {}

// ignore: must_be_immutable
class ToggleFavEvent extends FavButtonEvent {
  FavItem item;

  ToggleFavEvent({required this.item});
}

// ignore: must_be_immutable
class LoadFavEvent extends FavButtonEvent {
  LoadFavEvent();
}
