import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/products_gridview.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class CategorySearchScreen extends StatelessWidget {
  const CategorySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.searchWithLeading(),
      body: ListView(
        children: [
          Column(
            children: [
              TopTitle(
                topTitle: AppLocalization.of(context)
                        .getTransatedValues('recommended') ??
                    '',
                needArrow: false,
              ),
              const ProductsGridview(),
            ],
          ),
        ],
      ),
    );
  }
}