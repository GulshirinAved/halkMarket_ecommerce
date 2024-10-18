part of 'get_one_product_bloc.dart';

sealed class GetOneProductEvent extends Equatable {
  const GetOneProductEvent();

  @override
  List<Object> get props => [];
}

class GetOneProduct extends GetOneProductEvent {
  final String id;

  const GetOneProduct({required this.id});
  @override
  List<Object> get props => [id];
}
