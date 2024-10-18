import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/getAllProducts_repository.dart';

part 'get_all_products_event.dart';
part 'get_all_products_state.dart';

class GetAllProductsBloc
    extends Bloc<GetAllProductsEvent, GetAllProductsState> {
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  int page = 1;
  List<dynamic>? currentCategories;
  List<dynamic>? currentBrands;
  List<dynamic>? currentShops;
  int? currentPriceFrom;
  int? currentPriceTo;
  String? currentSearch;
  bool? currentDiscount;
  String? currentOrdering;

  GetAllProductsBloc() : super(GetAllProductsInitial()) {
    final GetAllProductsRepository getAllProductsRepository =
        GetAllProductsRepository();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLoadingMore) {
          add(const GetLoadMoreProducts());
        }
      }
    });

    on<GetProducts>((event, emit) async {
      try {
        page = 1;
        currentCategories = event.categories;
        currentBrands = event.brands;
        currentShops = event.shops;
        currentPriceFrom = event.priceFrom;
        currentPriceTo = event.priceTo;
        currentSearch = event.search;
        currentDiscount = event.discount;
        currentOrdering = event.ordering;

        final getAllProductsList =
            await getAllProductsRepository.fetchAllProductList(
          categories: currentCategories,
          brands: currentBrands,
          shops: currentShops,
          priceFrom: currentPriceFrom,
          priceTo: currentPriceTo,
          search: currentSearch,
          discount: currentDiscount,
          ordering: currentOrdering,
          page: page,
        );
        emit(GetAllProductsLoaded(getAllProductsList: getAllProductsList));
      } catch (e) {
        emit(GetAllProductsError(error: e.toString()));
      }
    });

    on<GetLoadMoreProducts>((event, emit) async {
      if (!isLoadingMore && state is GetAllProductsLoaded) {
        isLoadingMore = true;
        page++;
        final List<dynamic> allProductsList =
            await getAllProductsRepository.fetchAllProductList(
          page: page,
          categories: currentCategories,
          brands: currentBrands,
          shops: currentShops,
          priceFrom: currentPriceFrom,
          priceTo: currentPriceTo,
          search: currentSearch,
          discount: currentDiscount,
          ordering: currentOrdering,
        );
        if (allProductsList.isNotEmpty) {
          emit(
            GetAllProductsLoaded(
              getAllProductsList: [
                ...(state as GetAllProductsLoaded).getAllProductsList,
                ...allProductsList,
              ],
            ),
          );
        }
        isLoadingMore = false;
      }
    });
  }
}
