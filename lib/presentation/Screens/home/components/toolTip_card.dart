import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/blocs/home/answerTip/answering_tip_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_radio.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/toolTip_popUp.dart';

class ToolTipCard extends StatelessWidget {
  const ToolTipCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightPurpleColor,
        borderRadius: AppBorders.borderRadius16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //title
              Expanded(
                child: Text(
                  'Что вы знаете о фирменной косметике из ВкусВилла?',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: AppFonts.fontSize16,
                    color: AppColors.darkPurpleColor,
                  ),
                ),
              ),
              //tooltip
              const ToolTipPopUp(),
            ],
          ),
          //toolTip selection selection with radio
          Column(
            children: List.generate(
              tipQuestion.length,
              (index) => BlocBuilder<AnsweringTipBloc, AnsweringTipState>(
                builder: (context, state) {
                  return CustomRadio(
                    title: tipQuestion[index],
                    value: tipQuestion[index],
                    groupValue: state.selectedTip,
                    fontSize: AppFonts.fontSize10,
                    onChanged: (value) => context.read<AnsweringTipBloc>().add(
                          AnsweringTipEvent(
                            pressedTip: value ?? '',
                          ),
                        ),
                  );
                },
              ),
            ),
          ),
          //button
          CustomButton(
            width: 104,
            backColor: AppColors.purpleColor,
            textColor: AppColors.whiteColor,
            fontSize: AppFonts.fontSize10,
            title: 'Перейти в каталог',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
