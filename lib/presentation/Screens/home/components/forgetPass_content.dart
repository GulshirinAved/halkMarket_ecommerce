import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/forgetPass/forget_pass_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/passwordVisibility/password_obscure_cubit.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/login_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/otp_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ForgetPassContent extends StatefulWidget {
  const ForgetPassContent({super.key});

  @override
  State<ForgetPassContent> createState() => _ForgetPassContentState();
}

class _ForgetPassContentState extends State<ForgetPassContent> {
  late TextEditingController phoneController;
  late TextEditingController newPassController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: '+993 | ');
    newPassController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
        BlocProvider(
          create: (context) => ObscureCubit(),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //phone textfield
            PhoneTextField(phoneController: phoneController),
            //pass textfield
            PasswordTextField(passController: newPassController),

            BlocListener<ForgetPassBloc, ForgetPassState>(
              listener: (context, state) {
                if (state is ForgetPassLoaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    pushScreenWithoutNavBar(
                      context,
                      OtpScreen(
                        phoneNumber:
                            phoneController.text.replaceFirst('+993 | ', ''),
                      ),
                    );
                  });
                } else if (state is ForgetPassFailure) {
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
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustomButton.text(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  borderRadius: AppBorders.borderRadius12,
                  width: double.infinity,
                  backColor: AppColors.purpleColor,
                  textColor: AppColors.whiteColor,
                  fontSize: AppFonts.fontSize18,
                  title: AppLocalization.of(context)
                          .getTransatedValues('confirmCode') ??
                      '',
                  onTap: () {
                    final String phone =
                        phoneController.text.replaceFirst('+993 | ', '');
                    if (phone.length != 8 ||
                        newPassController.text.length < 8) {
                      context.read<ValidateTextFieldBloc>().add(
                            PhoneNumberChanged(
                                phoneNumber: phoneController.text),
                          );
                      context.read<ValidateTextFieldBloc>().add(
                            PasswordChanged(passWord: newPassController.text),
                          );
                    } else {
                      context.read<ForgetPassBloc>().add(
                            ForgetPassSubmitted(
                              phoneNumber: '+993$phone',
                              password: newPassController.text,
                            ),
                          );
                      context.read<ForgetPassBloc>().add(ResetForgetPass());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
