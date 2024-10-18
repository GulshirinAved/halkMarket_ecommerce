part of 'get_faq_bloc.dart';

sealed class GetFaqState extends Equatable {
  const GetFaqState();

  @override
  List<Object> get props => [];
}

final class GetFaqInitial extends GetFaqState {}

final class GetFaqLoaded extends GetFaqState {
  final List<Row> faqList;

  const GetFaqLoaded({required this.faqList});
  @override
  List<Object> get props => [faqList];
}

final class GetFaqError extends GetFaqState {
  final String error;

  const GetFaqError({required this.error});
  @override
  List<Object> get props => [error];
}
