import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/login/login_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/login_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({
    required this.phoneController,
    required this.passController,
    required this.pageController,
    super.key,
  });

  final TextEditingController phoneController;
  final TextEditingController passController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phone text field
          PhoneTextField(phoneController: phoneController),
          const SizedBox(height: 12),
          // Password text field
          PasswordTextField(passController: passController),
          GestureDetector(
            onTap: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 20),
              child: Text(
                AppLocalization.of(context).getTransatedValues('forgetPass') ??
                    '',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize16,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            ),
          ),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  pushScreenWithoutNavBar(
                    context,
                    const BottomNavBar(),
                  );
                });
              } else if (state is LoginFailure) {
                String message;
                switch (state.statusCode) {
                  case 602:
                    message = 'userExists';
                    break;
                  case 603:
                    message = 'otpinvalid';
                    break;
                  default:
                    message = 'error';
                }
                Animations().snackbar(context, message);
              }
            },
            child: CustomButton.text(
              padding: const EdgeInsets.symmetric(vertical: 16),
              borderRadius: AppBorders.borderRadius12,
              width: double.infinity,
              backColor: AppColors.purpleColor,
              textColor: AppColors.whiteColor,
              fontSize: AppFonts.fontSize18,
              title:
                  AppLocalization.of(context).getTransatedValues('login') ?? '',
              onTap: () {
                final String phone =
                    phoneController.text.replaceFirst('+993 | ', '');

                if (phone.length != 8 || passController.text.length < 8) {
                  context.read<ValidateTextFieldBloc>().add(
                        PhoneNumberChanged(phoneNumber: phoneController.text),
                      );
                  context.read<ValidateTextFieldBloc>().add(
                        PasswordChanged(passWord: passController.text),
                      );
                } else {
                  context.read<LoginBloc>().add(
                        LoginSubmitted(
                          phoneNumber: '+993$phone',
                          password: passController.text,
                        ),
                      );
                  context.read<LoginBloc>().add(const ResetLogin());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
