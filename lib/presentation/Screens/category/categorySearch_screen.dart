import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/products_gridview.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class CategorySearchScreen extends StatelessWidget {
  final bool? searchWithLeading;
  const CategorySearchScreen({super.key, this.searchWithLeading = true});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: searchWithLeading == true
            ? CustomAppBar.searchWithLeading()
            : CustomAppBar.onlySearch(),
        body: ListView(
          children: [
            Column(
              children: [
                TopTitle(
                  topTitle: AppLocalization.of(context)
                          .getTransatedValues('recommended') ??
                      '',
                  needArrow: false,
                  topMargin: 15,
                  bottomMargin: 12,
                ),
                ProductsGridview(
                  productList: newProducts,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
