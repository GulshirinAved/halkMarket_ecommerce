part of 'fav_button_bloc.dart';

sealed class FavButtonState extends Equatable {
  final List favList;

  const FavButtonState({required this.favList});

  @override
  List<Object> get props => [favList];
}

final class FavButtonInitial extends FavButtonState {
  const FavButtonInitial({required super.favList});
}

final class SuccessState extends FavButtonState {
  const SuccessState({required super.favList});
}
