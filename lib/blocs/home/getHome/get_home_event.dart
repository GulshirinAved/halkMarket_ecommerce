part of 'get_home_bloc.dart';

sealed class GetHomeEvent extends Equatable {
  const GetHomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeList extends GetHomeEvent {}
