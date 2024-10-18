// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/register/register_bloc.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/login_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/otp_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';

class RegisterTab extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;

  const RegisterTab({
    required this.phoneController,
    required this.passController,
    required this.confirmPassController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //phone textfield
            PhoneTextField(phoneController: phoneController),
            //pass textfield
            PasswordTextField(passController: passController),
            //verify pass textfield
            ConfirmPasswordField(confirmPassController: confirmPassController),
            //desc
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 15),
              child: Text(
                'SMS код отправлен на ваш телефон',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize16,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            ),
            //register button
            BlocListener<RegisterBloc, RegisterState>(
              listener: (context, registerState) {
                if (registerState is RegisterLoaded) {
                  if (registerState.statusCode == 200 ||
                      registerState.statusCode == 201) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      pushScreenWithoutNavBar(
                        context,
                        OtpScreen(
                          phoneNumber:
                              phoneController.text.replaceFirst('+993 | ', ''),
                        ),
                      );
                    });
                  }
                } else if (registerState is RegisterFailure) {
                  String message;
                  switch (registerState.statusCode) {
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
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, registerState) {
                  return BlocBuilder<ValidateTextFieldBloc,
                      ValidateTextFieldState>(
                    builder: (context, validateState) {
                      return CustomButton.text(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        borderRadius: AppBorders.borderRadius12,
                        width: double.infinity,
                        backColor: AppColors.purpleColor,
                        textColor: AppColors.whiteColor,
                        fontSize: AppFonts.fontSize18,
                        title: AppLocalization.of(context)
                                .getTransatedValues('register') ??
                            '',
                        onTap: () {
                          final String phone =
                              phoneController.text.replaceFirst('+993 | ', '');
                          if (phone.length != 8 ||
                              passController.text !=
                                  confirmPassController.text ||
                              confirmPassController.text.length < 8) {
                            context.read<ValidateTextFieldBloc>().add(
                                  PhoneNumberChanged(
                                    phoneNumber: phoneController.text,
                                  ),
                                );
                            context.read<ValidateTextFieldBloc>().add(
                                  PasswordChanged(
                                    passWord: passController.text,
                                  ),
                                );
                            context.read<ValidateTextFieldBloc>().add(
                                  VerifyPassChanged(
                                    verifyPass: confirmPassController.text,
                                  ),
                                );
                          } else {
                            context.read<RegisterBloc>().add(
                                  RegisterSubmitted(
                                    phoneNumber: '+993$phone',
                                    password: passController.text,
                                  ),
                                );
                            context.read<RegisterBloc>().add(ResetRegister());
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
