import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/getAllCategory_repository.dart';
import 'package:halkmarket_ecommerce/data/models/category_model.dart';

part 'all_category_event.dart';
part 'all_category_state.dart';

class AllCategoryBloc extends Bloc<AllCategoryEvent, AllCategoryState> {
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  AllCategoryBloc() : super(AllCategoryInitial()) {
    final GetAllCategoriesRepository getAllCategoriesRepository =
        GetAllCategoriesRepository();
    scrollController.addListener(
      () {
        add(LoadMoreEvent());
      },
    );

    on<GetAllCategoryList>((event, emit) async {
      isLoadingMore = false;

      try {
        final categoryCount =
            await getAllCategoriesRepository.fetchCountCategory(page: page);
        if (categoryCount != null) {
          final allCategoryList =
              await getAllCategoriesRepository.fetchCategoryProductList(
            page: page,
          );
          emit(
            AllCategoryLoaded(
              allCategoryList: allCategoryList,
            ),
          );
        }
      } catch (e) {
        emit(AllCategoryError(error: e.toString()));
      }
    });
    on<LoadMoreEvent>((event, emit) async {
      if (!isLoadingMore &&
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        page++;
        final additionalCategoryList = await getAllCategoriesRepository
            .fetchCategoryProductList(page: page);
        if (additionalCategoryList.isNotEmpty) {
          emit(
            AllCategoryLoaded(
              allCategoryList: [
                ...(state as AllCategoryLoaded).allCategoryList,
                ...additionalCategoryList,
              ],
            ),
          );

          isLoadingMore = false;
        }
      }
    });
  }
}
