import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:lottie/lottie.dart';

class Animations {
  static Center loading = Center(
    child: LottieBuilder.asset(
      loadingAnimation,
      height: 75,
    ),
  );
  static LottieBuilder empty = LottieBuilder.asset(emptyAnimation);
  static LottieBuilder nowifi = LottieBuilder.asset(
    nowifiAnimation,
    height: 95,
  );
  static LottieBuilder error = LottieBuilder.asset(errorAnimation);
  void snackbar(BuildContext context, final String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          AppLocalization.of(context).getTransatedValues(title) ?? '',
        ),
      ),
    );
  }
}
