part of 'get_one_cateloge_bloc.dart';

sealed class GetOneCatelogeEvent extends Equatable {
  const GetOneCatelogeEvent();

  @override
  List<Object> get props => [];
}

class GetOneCataloge extends GetOneCatelogeEvent {
  final String? id;

  const GetOneCataloge({required this.id});
  @override
  List<Object> get props => [id ?? ''];
}
