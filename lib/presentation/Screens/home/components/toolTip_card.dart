// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';

import 'package:halkmarket_ecommerce/blocs/home/answerTip/answering_tip_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/quizQn/get_quiz_qn_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/vote/vote_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_radio.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/toolTip_popUp.dart';

class ToolTipCard extends StatelessWidget {
  final PageController pageController;
  const ToolTipCard({
    required this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 20),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightPurpleColor,
        borderRadius: AppBorders.borderRadius16,
      ),
      child: BlocBuilder<GetQuizQnBloc, GetQuizQnState>(
        builder: (context, quizState) {
          if (quizState is GetQuizQnLoaded) {
            return PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              itemCount: quizState.questionList.length,
              itemBuilder: (context, index) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //title
                      Expanded(
                        child: Text(
                          quizState.questionList[index].title!,
                          style: TextStyle(
                            fontFamily: fontExo2,
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
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: quizState.questionList[index].answers!.length,
                      itemBuilder: (context, indexx) =>
                          BlocBuilder<AnsweringTipBloc, AnsweringTipState>(
                        builder: (context, state) {
                          return CustomRadio(
                            radioLeft: true,
                            title: quizState
                                .questionList[index].answers![indexx].title!,
                            value: quizState
                                .questionList[index].answers![indexx].title!,
                            groupValue: state.selectedTip,
                            fontSize: AppFonts.fontSize10,
                            onChanged: (value) =>
                                context.read<AnsweringTipBloc>().add(
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
                  BlocBuilder<AnsweringTipBloc, AnsweringTipState>(
                    builder: (context, state) {
                      return CustomButton.text(
                        width: 67,
                        borderRadius: AppBorders.borderRadius8,
                        backColor: AppColors.purpleColor,
                        textColor: AppColors.whiteColor,
                        fontSize: AppFonts.fontSize10,
                        title: AppLocalization.of(context)
                                .getTransatedValues('send') ??
                            '',
                        onTap: () {
                          if (state.selectedTip.isNotEmpty) {
                            context.read<VoteBloc>().add(
                                  VoteAnswer(
                                    id: quizState.questionList[index].id!,
                                  ),
                                );
                            Animations().snackbar(context, 'sendSuccess');
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
