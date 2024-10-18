import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/favButton/fav_button_bloc.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/product_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categorySearch_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.onlySearch(
        textEditingController: textEditingController,
        onTap: () =>
            pushScreenWithNavBar(context, const CategorySearchScreen()),
      ),
      body: BlocBuilder<FavButtonBloc, FavButtonState>(
        builder: (context, state) {
          if (state is FavButtonInitial || state.favList.isEmpty) {
            return const Center(
              child: Text(
                'There is no products ',
              ),
            );
          } else {
            return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.favList.length,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10).copyWith(top: 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 240,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => ProductCard(
                index: index,
                favItem: FavItem(
                  id: state.favList[index].id,
                  image: state.favList[index].image,
                  price: state.favList[index].price,
                  desc: state.favList[index].desc,
                  shopId: state.favList[index].shopId,
                  discount: state.favList[index].discount,
                  sugar: state.favList[index].sugar,
                  amount: state.favList[index].amount,
                  unit: state.favList[index].unit,
                ),
                cartItem: CartItem(
                  id: state.favList[index].id,
                  image: state.favList[index].image,
                  price: state.favList[index].price,
                  desc: state.favList[index].desc,
                  shopId: state.favList[index].shopId,
                  discount: state.favList[index].discount,
                  sugar: state.favList[index].sugar,
                  amount: state.favList[index].amount,
                  unit: state.favList[index].unit,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
