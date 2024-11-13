part of 'track_order_bloc.dart';

sealed class TrackOrderState extends Equatable {
  const TrackOrderState();

  @override
  List<Object> get props => [];
}

final class TrackOrderInitial extends TrackOrderState {}

final class TrackOrderNewLocationState extends TrackOrderState {}
