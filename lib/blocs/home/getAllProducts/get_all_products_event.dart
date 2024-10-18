part of 'get_all_products_bloc.dart';

sealed class GetAllProductsEvent extends Equatable {
  const GetAllProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends GetAllProductsEvent {
  final List? categories;
  final List? brands;
  final List? shops;
  final int? priceFrom;
  final int? priceTo;
  final String? ordering;
  final String? search;
  final bool? discount;

  const GetProducts({
    this.categories,
    this.brands,
    this.shops,
    this.priceFrom,
    this.priceTo,
    this.ordering,
    this.search,
    this.discount,
  });
}

class GetLoadMoreProducts extends GetAllProductsEvent {
  final int? page;
  final List? categories;
  final List? brands;
  final List? shops;
  final int? priceFrom;
  final int? priceTo;
  final String? ordering;
  final String? search;
  final bool? discount;

  const GetLoadMoreProducts({
    this.page,
    this.categories,
    this.brands,
    this.shops,
    this.priceFrom,
    this.priceTo,
    this.ordering,
    this.search,
    this.discount,
  });
}
