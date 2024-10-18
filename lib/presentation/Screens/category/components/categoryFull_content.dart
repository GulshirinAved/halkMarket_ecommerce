import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/selectSubCategory/select_sub_category_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/getAllProducts/get_all_products_bloc.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/product_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/subCategory_chip.dart';

class CategoryFullContent extends StatelessWidget {
  final TextEditingController fromPriceController;
  final TextEditingController toPriceController;
  final allProductState;
  final oneProductState;
  final PageController pageController;

  const CategoryFullContent({
    required this.fromPriceController,
    required this.toPriceController,
    required this.oneProductState,
    required this.allProductState,
    required this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Subcategory cards slider
        if (oneProductState.getOneCatalogeList.subcategories!.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(left: 20),
            height: 45,
            width: double.infinity,
            child: Row(
              children: [
                SubCategoryChip(
                  withIcon: true,
                  onTap: () {
                    pageController.nextPage(
                      duration: Durations.short1,
                      curve: Curves.bounceIn,
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: oneProductState
                        .getOneCatalogeList.subcategories?.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) => BlocBuilder<
                        SelectSubCategoryBloc, SelectSubCategoryState>(
                      builder: (context, selectState) {
                        return SubCategoryChip(
                          index: index,
                          oneProductState: oneProductState,
                          selectState: selectState,
                          onTap: () {
                            context.read<GetAllProductsBloc>().add(
                                  GetProducts(
                                    categories: [
                                      oneProductState.getOneCatalogeList
                                          .subcategories?[index].id,
                                    ],
                                  ),
                                );
                            context.read<SelectSubCategoryBloc>().add(
                                  SelectSubCategoryEvent(
                                    pressedIndex: index,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        // Products gridview
        if (allProductState.getAllProductsList.isNotEmpty)
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              controller:
                  BlocProvider.of<GetAllProductsBloc>(context).scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: allProductState.getAllProductsList.length + 1,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10).copyWith(top: 5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 240,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                if (index >= allProductState.getAllProductsList.length) {
                  if (!BlocProvider.of<GetAllProductsBloc>(context)
                      .isLoadingMore) {
                    BlocProvider.of<GetAllProductsBloc>(context)
                        .add(const GetLoadMoreProducts());
                  }
                  return allProductState.getAllProductsList.length != index
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink();
                }
                return ProductCard(
                  index: index,
                  favItem: FavItem(
                    id: allProductState.getAllProductsList[index].id,
                    image: allProductState.getAllProductsList[index].images,
                    price: allProductState.getAllProductsList[index].price,
                    desc: allProductState.getAllProductsList[index].description,
                    coin: allProductState.getAllProductsList[index].coin,
                    discount:
                        allProductState.getAllProductsList[index].discount,
                    shopId: allProductState.getAllProductsList[index].shopId,
                    amount: allProductState.getAllProductsList[index].amount,
                    unit: allProductState.getAllProductsList[index].unit,
                    name: allProductState.getAllProductsList[index].name,
                    sugar: allProductState.getAllProductsList[index].sugar,
                  ),
                  cartItem: CartItem(
                    id: allProductState.getAllProductsList[index].id,
                    image: allProductState.getAllProductsList[index].images,
                    price: allProductState.getAllProductsList[index].price,
                    desc: allProductState.getAllProductsList[index].description,
                    coin: allProductState.getAllProductsList[index].coin,
                    discount:
                        allProductState.getAllProductsList[index].discount,
                    shopId: allProductState.getAllProductsList[index].shopId,
                    amount: allProductState.getAllProductsList[index].amount,
                    unit: allProductState.getAllProductsList[index].unit,
                    name: allProductState.getAllProductsList[index].name,
                    sugar: allProductState.getAllProductsList[index].sugar,
                  ),
                );
              },
            ),
          ),
        if (allProductState.getAllProductsList.isEmpty)
          Column(
            children: [
              Animations.empty,
              Text(
                AppLocalization.of(context).getTransatedValues(
                      'searchEmpty',
                    ) ??
                    '',
              ),
            ],
          ),
      ],
    );
  }
}
