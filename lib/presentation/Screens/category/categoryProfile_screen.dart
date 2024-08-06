import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/selectSubCategory/select_sub_category_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categorySearch_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/filter_bottomSheet.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/products_gridview.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryProfileScreen extends StatefulWidget {
  final String topTitle;
  const CategoryProfileScreen({required this.topTitle, super.key});

  @override
  State<CategoryProfileScreen> createState() => _CategoryProfileScreenState();
}

class _CategoryProfileScreenState extends State<CategoryProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectSubCategoryBloc(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar.categoryProfile(
          title: widget.topTitle,
          actions: [
            IconButton(
              onPressed: () {
                filterBottomSheet(context);
              },
              icon: SvgPicture.asset(
                filterIcon,
              ),
            ),
            IconButton(
              onPressed: () {
                pushScreenWithNavBar(context, const CategorySearchScreen());
              },
              icon: SvgPicture.asset(
                searchIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.purpleColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: Column(
            children: [
              SizedBox(
                height: 45.h,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: subCategories.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => context
                        .read<SelectSubCategoryBloc>()
                        .add(SelectSubCategoryEvent(pressedIndex: index)),
                    child: BlocBuilder<SelectSubCategoryBloc,
                        SelectSubCategoryState>(
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.only(right: 6.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: state.index == index
                                ? AppColors.purpleColor
                                : AppColors.lightPurpleColor,
                            borderRadius: AppBorders.borderRadius8,
                          ),
                          child: Text(
                            subCategories[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: AppFonts.fontSize12,
                              color: state.index == index
                                  ? AppColors.whiteColor
                                  : AppColors.darkPurpleColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ProductsGridview(
                productList: newProducts,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
