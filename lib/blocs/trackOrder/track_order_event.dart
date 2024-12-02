part of 'track_order_bloc.dart';

sealed class TrackOrderEvent extends Equatable {
  const TrackOrderEvent();

  @override
  List<Object> get props => [];
}

class TrackOrderNewLocationEvent extends TrackOrderEvent {
  final List data;

  const TrackOrderNewLocationEvent({required this.data});
  @override
  List<Object> get props => [data];
}
