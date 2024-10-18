// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/home/selectCard/select_card_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class SelectionCard extends StatelessWidget {
  final List optionList;
  final List subTitle;
  final EdgeInsetsGeometry? padding;
  const SelectionCard({
    required this.optionList,
    this.subTitle = const [],
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 20, top: 16),
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderRadius12,
        border: Border.all(color: AppColors.grey5Color),
        color: AppColors.whiteColor,
      ),
      child: BlocBuilder<SelectCardCubit, int>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              optionList.length,
              (index) => GestureDetector(
                onTap: () =>
                    context.read<SelectCardCubit>().selectCard(index: index),
                child: Container(
                  width: MediaQuery.of(context).size.width / genderList.length -
                      36,
                  margin: const EdgeInsets.all(4),
                  padding: padding ??
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 11),
                  decoration: BoxDecoration(
                    color: state == index
                        ? AppColors.lightPurpleColor
                        : Colors.transparent,
                    borderRadius: AppBorders.borderRadius8,
                  ),
                  child: subTitle.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalization.of(context).getTransatedValues(
                                    optionList[index],
                                  ) ??
                                  '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: subTitle.isEmpty
                                    ? fontNunitoSans
                                    : fontExo2,
                                fontWeight: FontWeight.w400,
                                fontSize: subTitle.isEmpty
                                    ? AppFonts.fontSize14
                                    : AppFonts.fontSize16,
                                color: AppColors.darkPurpleColor,
                              ),
                            ),
                            Text(
                              subTitle[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: AppFonts.fontSize10,
                                color: AppColors.darkPurpleColor,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          AppLocalization.of(context).getTransatedValues(
                                optionList[index],
                              ) ??
                              '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: fontExo2,
                            fontWeight: FontWeight.w400,
                            fontSize: AppFonts.fontSize16,
                            color: AppColors.darkPurpleColor,
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
