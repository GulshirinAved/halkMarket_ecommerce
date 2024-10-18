part of 'internet_connection_bloc.dart';

sealed class InternetConnectionState extends Equatable {
  const InternetConnectionState();

  @override
  List<Object> get props => [];
}

final class InternetConnectionInitial extends InternetConnectionState {}

final class InternetConnectedState extends InternetConnectionState {
  const InternetConnectedState();
}

final class InternetNotConnectedState extends InternetConnectionState {
  const InternetNotConnectedState();
}
