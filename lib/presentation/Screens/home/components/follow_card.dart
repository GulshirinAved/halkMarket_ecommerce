import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/emailSubscription/subscription_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';

class FollowCard extends StatelessWidget {
  final TextEditingController emailController;
  const FollowCard({
    required this.emailController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 20),
      padding: const EdgeInsets.symmetric(
        vertical: 29,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.purpleColor,
            AppColors.lightPurple1Color,
          ],
        ),
        borderRadius: AppBorders.borderRadius16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //desc
          Text(
            AppLocalization.of(context).getTransatedValues('followDesc1') ?? '',
            style: TextStyle(
              fontFamily: fontExo2,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w800,
              fontSize: AppFonts.fontSize16,
            ),
          ),
          //deep desc
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              AppLocalization.of(context).getTransatedValues('followDesc2') ??
                  '',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.fontSize10,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //textfield
              BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                builder: (context, state) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 6),
                      child: CustomTextField.normal(
                        textEditingController: emailController,
                        hintText: AppLocalization.of(context)
                                .getTransatedValues('enterEmail') ??
                            '',
                        errorText: state.isVerifyEmailValid
                            ? ''
                            : AppLocalization.of(context)
                                .getTransatedValues('fillError'),
                        onChanged: (value) {
                          context
                              .read<ValidateTextFieldBloc>()
                              .add(EmailChanged(email: value));
                        },
                      ),
                    ),
                  );
                },
              ),
              //follow button
              BlocListener<SubscriptionBloc, SubscriptionState>(
                listener: (context, state) {
                  if (state is SubscriptionError) {
                    Animations().snackbar(context, 'error');
                  } else if (state is SubscriptionLoaded) {
                    Animations().snackbar(context, 'successFollow');
                  }
                },
                child: CustomButton.text(
                  borderRadius: AppBorders.borderRadius8,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: 88,
                  backColor: AppColors.whiteColor,
                  textColor: AppColors.darkPurpleColor,
                  fontSize: AppFonts.fontSize10,
                  title: AppLocalization.of(context)
                          .getTransatedValues('subscribe') ??
                      '',
                  fontweight: FontWeight.w700,
                  onTap: () {
                    context
                        .read<SubscriptionBloc>()
                        .add(Follow(email: emailController.text));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
