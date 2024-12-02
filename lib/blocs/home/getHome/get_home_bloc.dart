import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/getHome_repository.dart';
import 'package:halkmarket_ecommerce/data/models/getHome_model.dart.dart';

part 'get_home_event.dart';
part 'get_home_state.dart';

class GetHomeBloc extends Bloc<GetHomeEvent, GetHomeState> {
  GetHomeBloc() : super(GetHomeInitial()) {
    final GetHomeRepository getHomeRepository = GetHomeRepository();

    on<GetHomeList>((event, emit) async {
      try {
        final getHomeBannerList = await getHomeRepository.fetchHomeBanner();
        final getPopularCategoryList =
            await getHomeRepository.fetchPopularCategory();
        final getSmallCategoryList =
            await getHomeRepository.fetchSmallCategory();
        final getHomeProducts = await getHomeRepository.fetchAllHomeProducts();
        final getHomeData = await getHomeRepository.fetchAllHomeData();

        emit(
          GetHomeLoaded(
            getHomeBannerList: getHomeBannerList,
            getPopularCategoryList: getPopularCategoryList,
            getSmallCategoryList: getSmallCategoryList,
            getHomeProducts: getHomeProducts,
            getHomeData: getHomeData,
          ),
        );
      } catch (e) {
        log('it is bloc exception $e');

        emit(GetHomeError(error: e.toString()));
      }
    });
  }
}
