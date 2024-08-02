import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/category_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        stateManagement: true,
        tabs: List.generate(
          bottomNavBarItemName.length,
          (index) => PersistentTabConfig(
            screen: getScreenForIndex(index),
            item: ItemConfig(
              activeForegroundColor: AppColors.purpleColor,
              filter: ColorFilter.mode(AppColors.purpleColor, BlendMode.srcIn),
              inactiveIcon: SvgPicture.asset(
                bottomNavBarItemName[index]['icon'],
              ),
              icon: SvgPicture.asset(
                bottomNavBarItemName[index]['iconBold'],
              ),
              activeColorSecondary: AppColors.purpleColor,
            ),
          ),
        ),
        navBarBuilder: (navBarConfig) => Style4BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
              filter: ColorFilter.mode(AppColors.purpleColor, BlendMode.srcIn)),
        ),
      ),
    );
  }

  Widget getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CategoryScreen();
      case 2:
        return Container();
      case 3:
        return Container();
      default:
        return Container();
    }
  }
}
