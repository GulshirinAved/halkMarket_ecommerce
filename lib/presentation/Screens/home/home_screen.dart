// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';

import 'package:halkmarket_ecommerce/blocs/home/answerTip/answering_tip_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/bannerSlider/banner_slider_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/home/emailSubscription/subscription_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/getHome/get_home_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/quizQn/get_quiz_qn_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/vote/vote_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/map/addDeliveryLocation/location_add_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_cubit.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categorySearch_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/banner_slider.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/deliveryAddress_tile.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/follow_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/popularProducts_gridview.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/products_slider.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/smallCategory_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/toolTip_card.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController textEditingController;
  late TextEditingController emailController;
  late AnsweringTipBloc answeringTipBloc;
  late BannerSliderCubit bannerSliderCubit;
  late LocationAddBloc locationAddBloc;
  late GetHomeBloc getHomeBloc;
  late GetQuizQnBloc getQuizQnBloc;
  late VoteBloc voteBloc;

  late LocationCubit locationCubit;
  late SubscriptionBloc subscriptionBloc;
  late ValidateTextFieldBloc validateTextFieldBloc;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    emailController = TextEditingController();
    answeringTipBloc = AnsweringTipBloc();
    bannerSliderCubit = BannerSliderCubit();
    locationAddBloc = LocationAddBloc()..add(const ShowSavedLocationEvent());
    getHomeBloc = GetHomeBloc()..add(GetHomeList());
    getQuizQnBloc = GetQuizQnBloc()..add(GetQuestionEvent());
    voteBloc = VoteBloc();
    locationCubit = LocationCubit();
    subscriptionBloc = SubscriptionBloc();
    validateTextFieldBloc = ValidateTextFieldBloc();
    pageController = PageController();
  }

  Future<void> _refresh() async {
    getHomeBloc.add(GetHomeList());
    getQuizQnBloc.add(GetQuestionEvent());
  }

  @override
  void dispose() {
    textEditingController.dispose();
    emailController.dispose();
    answeringTipBloc.close();
    bannerSliderCubit.close();
    locationAddBloc.close();
    getHomeBloc.close();
    locationCubit.close();
    subscriptionBloc.close();
    validateTextFieldBloc.close();
    getQuizQnBloc.close();
    pageController.dispose();
    voteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: answeringTipBloc,
        ),
        BlocProvider.value(
          value: bannerSliderCubit,
        ),
        BlocProvider.value(
          value: locationAddBloc,
        ),
        BlocProvider.value(
          value: getHomeBloc,
        ),
        BlocProvider.value(
          value: locationCubit,
        ),
        BlocProvider.value(
          value: subscriptionBloc,
        ),
        BlocProvider.value(
          value: validateTextFieldBloc,
        ),
        BlocProvider.value(
          value: getQuizQnBloc,
        ),
        BlocProvider.value(
          value: voteBloc,
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: RefreshIndicator.adaptive(
            color: AppColors.purpleColor,
            backgroundColor: AppColors.whiteColor,
            onRefresh: _refresh,
            child: CustomScrollView(
              slivers: [
                //appbar
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: false,
                  expandedHeight: 120,
                  flexibleSpace: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: DeliveryAddressTile(),
                  ),
                  bottom: CustomAppBar.onlySearch(
                    textEditingController: textEditingController,
                    onTap: () {
                      pushScreenWithNavBar(
                        context,
                        const CategorySearchScreen(
                          searchWithLeading: false,
                        ),
                      );
                    },
                  ),
                ),
                //body
                SliverToBoxAdapter(
                  child: BlocBuilder<GetQuizQnBloc, GetQuizQnState>(
                    builder: (context, quizState) {
                      return BlocBuilder<GetHomeBloc, GetHomeState>(
                        builder: (context, state) {
                          if (state is GetHomeError) {
                            log(state.error.toString());
                            return Column(
                              children: [
                                Animations.error,
                                Text(
                                  AppLocalization.of(context)
                                          .getTransatedValues('error') ??
                                      '',
                                ),
                              ],
                            );
                          } else if (state is GetHomeInitial ||
                              state is GetHomeLoading ||
                              quizState is GetQuizQnInitial) {
                            return Center(
                              child: Animations.loading,
                            );
                          } else if (state is GetHomeLoaded &&
                              quizState is GetQuizQnLoaded) {
                            return Column(
                              children: [
//banner
                                BannerSlider(
                                  imageList: state.getHomeBannerList ?? [],
                                ),
                                //small categories
                                SizedBox(
                                  height: 88,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        state.getSmallCategoryList!.length,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        SmallCategoryCard(
                                      index: index,
                                      categoryList:
                                          state.getSmallCategoryList ?? [],
                                    ),
                                  ),
                                ),
                                //product slider
                                Column(
                                  children: [
                                    for (int i = 0; i < 2; i++)
                                      if (i < state.getHomeData.length)
                                        ProductsSlider(
                                          index: i,
                                          topTitle: state.getHomeData[i]
                                                  .category?.name ??
                                              'Default Category Name',
                                          categoryId:
                                              state.getHomeData[i].categoryId,
                                          productList: state.getHomeProducts[i],
                                        ),
                                  ],
                                ),
                                //popular cards
                                state.getPopularCategoryList!.isEmpty
                                    ? const SizedBox.shrink()
                                    : PopularProductsGridview(
                                        popularList:
                                            state.getPopularCategoryList ?? [],
                                      ),
                                //products slider
                                Column(
                                  children: [
                                    for (int i = 2; i < 4; i++)
                                      if (i < state.getHomeData.length)
                                        ProductsSlider(
                                          index: i,
                                          topTitle: state.getHomeData[i]
                                                  .category?.name ??
                                              'Default Category Name',
                                          categoryId:
                                              state.getHomeData[i].categoryId,
                                          productList: state.getHomeProducts[i],
                                        ),
                                  ],
                                ),
                                //quiz
                                ToolTipCard(
                                  pageController: pageController,
                                ),
                                //product slider
                                Column(
                                  children: [
                                    for (int i = 4; i < 6; i++)
                                      if (i < state.getHomeData.length)
                                        ProductsSlider(
                                          index: i,
                                          topTitle: state.getHomeData[i]
                                                  .category?.name ??
                                              'Default Category Name',
                                          categoryId:
                                              state.getHomeData[i].categoryId,
                                          productList: state.getHomeProducts[i],
                                        ),
                                  ],
                                ),
                                //follow card
                                FollowCard(
                                  emailController: emailController,
                                ),
                                //product slider
                                Column(
                                  children: [
                                    for (int i = 6; i < 8; i++)
                                      if (i < state.getHomeData.length)
                                        ProductsSlider(
                                          index: i,
                                          topTitle: state.getHomeData[i]
                                                  .category?.name ??
                                              'Default Category Name',
                                          categoryId:
                                              state.getHomeData[i].categoryId,
                                          productList: state.getHomeProducts[i],
                                        ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Animations.loading,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
