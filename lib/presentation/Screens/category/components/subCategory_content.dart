// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halkmarket_ecommerce/blocs/category/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/expansionPanelExpand/expansion_panel_expand_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/getAllProducts/get_all_products_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class SubCategoryContent extends StatelessWidget {
  final PageController pageController;
  const SubCategoryContent({
    required this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOneCatelogeBloc, GetOneCatelogeState>(
      builder: (context, state) {
        if (state is GetOneCatalogeLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                ExpansionPanelList.radio(
                  elevation: 0,
                  materialGapSize: 5,
                  expansionCallback: (panelIndex, isExpanded) {
                    final entry =
                        state.getOneCatalogeList.subcategories![panelIndex];
                    if (entry.subcategories!.isEmpty) {
                      context.read<GetAllProductsBloc>().add(
                            GetProducts(
                              categories: [entry.id],
                            ),
                          );
                      pageController.previousPage(
                        duration: Durations.short1,
                        curve: Curves.bounceIn,
                      );
                    } else {
                      context.read<ExpansionPanelExpandBloc>().add(
                            PressEvent(panelIndex: panelIndex),
                          );
                    }
                  },
                  children: state.getOneCatalogeList.subcategories!
                      .map(
                        (entry) => ExpansionPanelRadio(
                          backgroundColor: AppColors.whiteColor,
                          value: entry.id!,
                          headerBuilder: (context, isExpanded) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            trailing: entry.subcategories!.isEmpty
                                ? const SizedBox.shrink()
                                : Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: AppColors.purpleColor,
                                  ),
                            title: Text(
                              entry.name!,
                              style: TextStyle(
                                color: AppColors.darkPurpleColor,
                                fontSize: AppFonts.fontSize16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          body: entry.subcategories!.isEmpty
                              ? const SizedBox.shrink()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: entry.subcategories!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        context.read<GetAllProductsBloc>().add(
                                              GetProducts(
                                                categories: [
                                                  entry
                                                      .subcategories![index].id,
                                                ],
                                              ),
                                            );
                                        pageController.previousPage(
                                          duration: Durations.short1,
                                          curve: Curves.bounceIn,
                                        );
                                      },
                                      title: Text(
                                        entry.subcategories![index].name!,
                                        style: TextStyle(
                                          color: AppColors.darkPurpleColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: AppFonts.fontSize14,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          canTapOnHeader: true,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
