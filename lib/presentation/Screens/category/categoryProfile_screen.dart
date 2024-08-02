import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/bloc/select_sub_category_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/products_gridview.dart';

class CategoryProfileScreen extends StatelessWidget {
  final String topTitle;
  const CategoryProfileScreen({super.key, required this.topTitle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectSubCategoryBloc(),
      child: Scaffold(
        appBar: CustomAppBar.categoryProfile(
          title: topTitle,
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                filterIcon,
              ),
            ),
            IconButton(
              onPressed: () {},
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
        body: Column(
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
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightPurpleColor,
                          borderRadius: AppBorders.borderRadius8,
                          border: Border.all(
                            color: state.index == index
                                ? AppColors.darkPurpleColor
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          subCategories[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: AppFonts.fontSize12,
                            color: AppColors.darkPurpleColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const Expanded(child: ProductsGridview()),
          ],
        ),
      ),
    );
  }
}
