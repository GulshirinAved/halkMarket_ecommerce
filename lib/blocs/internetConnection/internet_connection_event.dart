part of 'internet_connection_bloc.dart';

class InternetConnectionEvent extends Equatable {
  const InternetConnectionEvent();

  @override
  List<Object> get props => [];
}

final class InternetConnectedEvent extends InternetConnectionEvent {
  const InternetConnectedEvent();
}

final class InternetNotConnectedEvent extends InternetConnectionEvent {
  const InternetNotConnectedEvent();
}

final class InternetListenEvent extends InternetConnectionEvent {
  const InternetListenEvent();
}
