part of 'get_faq_bloc.dart';

sealed class GetFaqEvent extends Equatable {
  const GetFaqEvent();

  @override
  List<Object> get props => [];
}

final class GetFaqList extends GetFaqEvent {}
