// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/productProfile/dotIndicator/dot_indicator_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/productProfile/expanableText/expandable_text_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/productProfile/getOneProduct/get_one_product_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/productProfile/imageScrolling/image_scrolling_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/fav_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/product_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartQuantity_buttons.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/expandable_text.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/image_slider.dart';
import 'package:share_plus/share_plus.dart';

class ProductProfileScreen extends StatefulWidget {
  final FavItem favItem;
  final CartItem cartItem;
  final int index;
  const ProductProfileScreen({
    required this.favItem,
    required this.cartItem,
    required this.index,
    super.key,
  });

  @override
  State<ProductProfileScreen> createState() => _ProductProfileScreenState();
}

class _ProductProfileScreenState extends State<ProductProfileScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetOneProductBloc()..add(GetOneProduct(id: widget.favItem.id)),
        ),
        BlocProvider(
          create: (context) => ImageScrollingBloc(),
        ),
        BlocProvider(
          create: (context) => ExpandableTextCubit(),
        ),
        BlocProvider(
          create: (context) => DotIndicatorBloc(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar.categoryProfile(
              title: widget.favItem.name ?? '',
              actions: [
                IconButton(
                  onPressed: () {
                    Share.share(
                      '${Endpoints().url}/${widget.favItem.image![0].url}',
                    );
                  },
                  icon: SvgPicture.asset(shareIcon),
                ),
              ],
            ),
            body: BlocBuilder<GetOneProductBloc, GetOneProductState>(
              builder: (context, state) {
                if (state is GetOneProductError) {
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
                } else if (state is GetOneProductInitial ||
                    state is GetOneProductLoading) {
                  return Animations.loading;
                } else if (state is GetOneProductLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        //image slider
                        ImageSlider(
                          pageController: _pageController,
                          imageList: state.getOneProductList.product!.images!,
                        ),
                        //price and discount
                        Text(
                          state.getOneProductList.product!.name ?? '',
                          style: TextStyle(
                            fontFamily: fontExo2,
                            fontWeight: FontWeight.w700,
                            fontSize: AppFonts.fontSize18,
                            color: AppColors.darkPurpleColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${state.getOneProductList.product!.price}.${state.getOneProductList.product!.coin} TMT',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppFonts.fontSize20,
                                color: AppColors.darkPurpleColor,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            state.getOneProductList.product!.discount == null
                                ? Text(
                                    '${state.getOneProductList.product!.discount!.discount}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: AppFonts.fontSize14,
                                      color: AppColors.red1Color,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        //add cart button

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<CartButtonBloc, CartButtonState>(
                              builder: (context, state) {
                                final isItemInCart = state.cartList.any(
                                  (item) => item?.id == widget.cartItem.id,
                                );
                                return Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  width: MediaQuery.of(context).size.width - 85,
                                  child: isItemInCart
                                      ? CartQuantityButtons(
                                          cartItem: widget.cartItem,
                                        )
                                      : CustomButton.text(
                                          width: double.infinity,
                                          backColor: AppColors.purpleColor,
                                          textColor: AppColors.whiteColor,
                                          fontSize: AppFonts.fontSize16,
                                          title: AppLocalization.of(context)
                                                  .getTransatedValues(
                                                'addCart',
                                              ) ??
                                              '',
                                          onTap: () {
                                            if (!isItemInCart) {
                                              context
                                                  .read<CartButtonBloc>()
                                                  .add(
                                                    AddCartEvent(
                                                      cartItem: widget.cartItem,
                                                    ),
                                                  );
                                              Animations().snackbar(
                                                context,
                                                'addedToCart',
                                              );
                                            }
                                          },
                                          borderRadius:
                                              AppBorders.borderRadius12,
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 13,
                                          ),
                                        ),
                                );
                              },
                            ),
                            FavButton(
                              containerSize: 44,
                              padding: 12,
                              favItem: widget.favItem,
                              borderRadius: AppBorders.borderRadius12,
                            ),
                          ],
                        ),
                        //description
                        TopTitleText(
                          topTitle: AppLocalization.of(context)
                                  .getTransatedValues('desc') ??
                              '',
                          text: state.getOneProductList.product!.description ??
                              '',
                        ),
                        //compound
                        state.getOneProductList.product!.compound == null ||
                                state.getOneProductList.product!.compound == ''
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalization.of(context)
                                              .getTransatedValues(
                                            'compound',
                                          ) ??
                                          '',
                                      style: TextStyle(
                                        color: AppColors.grey1Color,
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppFonts.fontSize14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    ExpandableText(
                                      text: state.getOneProductList.product!
                                              .compound ??
                                          '',
                                    ),
                                  ],
                                ),
                              ),
                        state.getOneProductList.product!.expiresIn == null
                            ? const SizedBox.shrink()
                            : TopTitleText(
                                topTitle: AppLocalization.of(context)
                                        .getTransatedValues('expireDate') ??
                                    '',
                                text: state
                                        .getOneProductList.product!.expiresIn ??
                                    '',
                              ),
                        TopTitleText(
                          topTitle: AppLocalization.of(context)
                                  .getTransatedValues('weight') ??
                              '',
                          text:
                              '${state.getOneProductList.product!.amount} ${state.getOneProductList.product!.unit!.name}',
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalization.of(context).getTransatedValues(
                                    'similiarProducts',
                                  ) ??
                                  '',
                              style: TextStyle(
                                fontFamily: fontExo2,
                                fontWeight: FontWeight.w700,
                                fontSize: AppFonts.fontSize18,
                                color: AppColors.darkPurpleColor,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state
                                  .getOneProductList.similaryProducts!.length,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 240,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                index: index,
                                favItem: FavItem(
                                  id: state.getOneProductList
                                      .similaryProducts![index].id!,
                                  image: state.getOneProductList
                                      .similaryProducts![index].images,
                                  price: state.getOneProductList
                                      .similaryProducts![index].price,
                                  desc: state.getOneProductList
                                      .similaryProducts![index].description,
                                  shopId: state.getOneProductList
                                      .similaryProducts![index].shopId,
                                  amount: state.getOneProductList
                                      .similaryProducts![index].amount,
                                  unit: state.getOneProductList
                                      .similaryProducts![index].unit,
                                ),
                                cartItem: CartItem(
                                  id: state.getOneProductList
                                      .similaryProducts![index].id!,
                                  image: state.getOneProductList
                                      .similaryProducts![index].images,
                                  price: state.getOneProductList
                                      .similaryProducts![index].price,
                                  desc: state.getOneProductList
                                      .similaryProducts![index].description,
                                  shopId: state.getOneProductList
                                      .similaryProducts![index].shopId,
                                  amount: state.getOneProductList
                                      .similaryProducts![index].amount,
                                  unit: state.getOneProductList
                                      .similaryProducts![index].unit,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}

class TopTitleText extends StatelessWidget {
  final String topTitle;
  final String text;
  const TopTitleText({
    required this.topTitle,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topTitle,
            style: TextStyle(
              color: AppColors.grey1Color,
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize14,
              color: AppColors.darkPurpleColor,
            ),
          ),
        ],
      ),
    );
  }
}
