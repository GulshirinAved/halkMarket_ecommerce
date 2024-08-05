import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/favButton/fav_button_bloc.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/products_gridview.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.onlySearch(),
      body: BlocBuilder<FavButtonBloc, FavButtonState>(
        builder: (context, state) {
          if (state is FavButtonInitial || state.favList.isEmpty) {
            return const Center(
              child: Text(
                'There is no products ',
              ),
            );
          } else {
            return ProductsGridview(
              productList: state.favList,
            );
          }
        },
      ),
    );
  }
}
