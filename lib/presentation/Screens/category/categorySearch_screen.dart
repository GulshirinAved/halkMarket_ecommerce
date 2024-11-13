import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/home/getAllProducts/get_all_products_bloc.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/product_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class CategorySearchScreen extends StatefulWidget {
  final bool? searchWithLeading;
  const CategorySearchScreen({super.key, this.searchWithLeading = true});

  @override
  State<CategorySearchScreen> createState() => _CategorySearchScreenState();
}

class _CategorySearchScreenState extends State<CategorySearchScreen> {
  late TextEditingController textEditingController;
  Timer? _debounceTimer;
  late GetAllProductsBloc getAllProductBloc;

  @override
  void initState() {
    super.initState();
    getAllProductBloc = GetAllProductsBloc();
    textEditingController = TextEditingController();
    textEditingController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    getAllProductBloc.close();
    textEditingController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      getAllProductBloc.add(
        GetProducts(
          search: textEditingController.text,
          ordering: 'recommended',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getAllProductBloc
        ..add(
          GetProducts(
            search: textEditingController.text,
            ordering: 'recommended',
          ),
        ),
      child: PopScope(
        onPopInvoked: (value) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: widget.searchWithLeading == true
              ? CustomAppBar.searchWithLeading(
                  textEditingController: textEditingController,
                  onFieldSubmitted: (value) {
                    textEditingController.text = value;
                    context.read<GetAllProductsBloc>().add(
                          GetProducts(ordering: 'popular', search: value),
                        );
                  },
                )
              : CustomAppBar.onlySearch(
                  textEditingController: textEditingController,
                  onFieldSubmitted: (value) {
                    textEditingController.text = value;
                    context.read<GetAllProductsBloc>().add(
                          GetProducts(ordering: 'popular', search: value),
                        );
                  },
                ),
          body: BlocBuilder<GetAllProductsBloc, GetAllProductsState>(
            builder: (context, state) {
              if (state is GetAllProductsError) {
                return Center(
                  child: Column(
                    children: [
                      Animations.error,
                      Text(
                        AppLocalization.of(context)
                                .getTransatedValues('error') ??
                            '',
                      ),
                    ],
                  ),
                );
              } else if (state is GetAllProductsInitial ||
                  state is GetAllProductsloading) {
                return Animations.loading;
              } else if (state is GetAllProductsLoaded) {
                if (state.getAllProductsList.isEmpty) {
                  return Column(
                    children: [
                      Animations.empty,
                      Text(
                        AppLocalization.of(context)
                                .getTransatedValues('searchEmpty') ??
                            '',
                      ),
                    ],
                  );
                }
                return ListView(
                  children: [
                    if (textEditingController.text.isEmpty)
                      TopTitle(
                        topTitle: AppLocalization.of(context)
                                .getTransatedValues('recommended') ??
                            '',
                        needArrow: false,
                        topMargin: 15,
                        bottomMargin: 12,
                      ),
                    GridView.builder(
                      controller: BlocProvider.of<GetAllProductsBloc>(context)
                          .scrollController,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.getAllProductsList.length + 1,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(10).copyWith(top: 0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 243,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        if (index >= state.getAllProductsList.length) {
                          if (!BlocProvider.of<GetAllProductsBloc>(context)
                              .isLoadingMore) {
                            BlocProvider.of<GetAllProductsBloc>(context)
                                .add(const GetLoadMoreProducts());
                          }
                          return state.getAllProductsList.length != index
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const SizedBox.shrink();
                        }
                        return ProductCard(
                          index: index,
                          favItem: FavItem(
                            id: state.getAllProductsList[index].id,
                            image: state.getAllProductsList[index].images,
                            price: state.getAllProductsList[index].price,
                            desc: state.getAllProductsList[index].description,
                            shopId: state.getAllProductsList[index].shopId,
                            discount: state.getAllProductsList[index].discount,
                            coin: state.getAllProductsList[index].coin,
                            amount: state.getAllProductsList[index].amount,
                            unit: state.getAllProductsList[index].unit,
                            name: state.getAllProductsList[index].name,
                            sugar: state.getAllProductsList[index].sugar,
                          ),
                          cartItem: CartItem(
                            id: state.getAllProductsList[index].id,
                            image: state.getAllProductsList[index].images,
                            price: state.getAllProductsList[index].price,
                            desc: state.getAllProductsList[index].description,
                            shopId: state.getAllProductsList[index].shopId,
                            discount: state.getAllProductsList[index].discount,
                            coin: state.getAllProductsList[index].coin,
                            amount: state.getAllProductsList[index].amount,
                            unit: state.getAllProductsList[index].unit,
                            name: state.getAllProductsList[index].name,
                            sugar: state.getAllProductsList[index].sugar,
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
