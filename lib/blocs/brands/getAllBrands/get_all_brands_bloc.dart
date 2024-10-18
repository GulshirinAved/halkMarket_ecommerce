import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/getAllBrands_repository.dart';

part 'get_all_brands_event.dart';
part 'get_all_brands_state.dart';

class GetAllBrandsBloc extends Bloc<GetAllBrandsEvent, GetAllBrandsState> {
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  final String currentCategoryId = '';

  GetAllBrandsBloc() : super(GetAllBrandsInitial()) {
    final GetAllBrandsRepository getAllBrandsRepository =
        GetAllBrandsRepository();

    on<GetAllBrandsList>((event, emit) async {
      isLoadingMore = false;
      try {
        final allBrandsList = await getAllBrandsRepository.fetchAllBrandsList(
          page: 1,
        );
        emit(GetAllBrandsLoaded(allBrandsList: allBrandsList));
      } catch (e) {
        emit(GetAllBrandsError(error: e.toString()));
      }
    });
    on<GetMoreBrand>((event, emit) async {
      if (!isLoadingMore && state is GetAllBrandsLoaded) {
        isLoadingMore = true;
        page++;
        final allBrandsList = await getAllBrandsRepository.fetchAllBrandsList(
          page: page,
        );
        if (allBrandsList.isNotEmpty) {
          emit(
            GetAllBrandsLoaded(
              allBrandsList: [
                ...(state as GetAllBrandsLoaded).allBrandsList,
                ...allBrandsList,
              ],
            ),
          );
        }
        isLoadingMore = false;
      }
    });
  }
}
