import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/language/language_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

Future<dynamic> langBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: AppColors.whiteColor,
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
// Top title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalization.of(context).getTransatedValues('chooseLang') ??
                    '',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFonts.fontSize18,
                  color: AppColors.darkPurpleColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.clear,
                  size: 20,
                  color: AppColors.grey1Color,
                ),
              ),
            ],
          ),
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return Column(
                children: [
                  for (int i = 0; i < langList.length; i++)
                    GestureDetector(
                      onTap: () {
                        i == 0
                            ? context
                                .read<LanguageBloc>()
                                .add(TurkmenLanguageEvent())
                            : context
                                .read<LanguageBloc>()
                                .add(RussianLanguageEvent());
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: (state as ChangeLanguageState).languageCode ==
                                          'tr' &&
                                      i == 0 ||
                                  (state as ChangeLanguageState).languageCode ==
                                          'ru' &&
                                      i == 1
                              ? AppColors.lightPurpleColor
                              : AppColors.whiteColor,
                          borderRadius: AppBorders.borderRadius8,
                        ),
                        child: Text(
                          langList[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: AppFonts.fontSize16,
                            color: AppColors.darkPurpleColor,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}
