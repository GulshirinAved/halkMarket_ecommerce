// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/blocs/auth/forgetPass/forget_pass_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/login/login_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/register/register_bloc.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/login_tab.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/register_tab.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/category/tabBar/tab_bar_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/home/passwordVisibility/password_obscure_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_tabbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController signUpPhoneController;
  late TextEditingController signUpPassController;
  late TextEditingController signUpVerifyPassController;
  late TextEditingController loginPhoneController;
  late TextEditingController loginPassController;

  @override
  void initState() {
    super.initState();
    signUpPhoneController = TextEditingController(text: '+993 | ');
    signUpPassController = TextEditingController();
    signUpVerifyPassController = TextEditingController();
    loginPhoneController = TextEditingController(text: '+993 | ');
    loginPassController = TextEditingController();
  }

  @override
  void dispose() {
    signUpPhoneController.dispose();
    signUpPassController.dispose();
    signUpVerifyPassController.dispose();
    loginPhoneController.dispose();
    loginPassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabCubit(),
        ),
        BlocProvider(
          create: (context) => ObscureCubit(),
        ),
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ForgetPassBloc(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CustomAppBar.leadingTitle(
            title:
                AppLocalization.of(context).getTransatedValues('profile') ?? '',
            centerTitle: false,
            leadingWidth: 20,
            titleTap: true,
            fontSize: AppFonts.fontSize15,
            textColor: AppColors.purpleColor,
            needBoxshadow: false,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //logo
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  halkMarketImage,
                  alignment: Alignment.topCenter,
                ),
              ),
              //tabbar
              Container(
                height: 47,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: AppBorders.borderRadius8,
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.grey5Color),
                ),
                child: BlocBuilder<TabCubit, int>(
                  builder: (context, state) {
                    return CustomTabBar(
                      onTap: (index) =>
                          context.read<TabCubit>().changeTab(index),
                      leftTitle: AppLocalization.of(context)
                              .getTransatedValues('register') ??
                          '',
                      rightTitle: AppLocalization.of(context)
                              .getTransatedValues('login') ??
                          '',
                      fontSize: AppFonts.fontSize18,
                      activeTextColor: AppColors.darkPurpleColor,
                      indicatorColor: AppColors.lightPurpleColor,
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<TabCubit, int>(
                  builder: (context, state) {
                    return IndexedStack(
                      index: state,
                      children: [
                        //!!!!!register!!!!!!!!
                        RegisterTab(
                          phoneController: signUpPhoneController,
                          passController: signUpPassController,
                          confirmPassController: signUpVerifyPassController,
                        ),
                        // !!!!login!!!!!!!
                        LoginTab(
                          phoneController: loginPhoneController,
                          passController: loginPassController,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
    required this.confirmPassController,
    super.key,
  });

  final TextEditingController confirmPassController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObscureCubit, ObscureState>(
      builder: (context, obscureState) {
        return BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
          builder: (context, state) {
            return CustomTextField.normal(
              backColor: AppColors.whiteColor,
              borderColor: AppColors.purpleColor,
              nonActiveBorderColor: AppColors.grey5Color,
              textEditingController: confirmPassController,
              isObscure: obscureState.isConfirmPasswordObscured,
              keyboardType: TextInputType.text,
              errorText: state.isVerifyPassValid
                  ? ''
                  : AppLocalization.of(context)
                          .getTransatedValues('errorVerifyPass') ??
                      '',
              labelText: AppLocalization.of(context)
                      .getTransatedValues('confirmPass') ??
                  '',
              onChanged: (value) {
                context
                    .read<ValidateTextFieldBloc>()
                    .add(VerifyPassChanged(verifyPass: value));
                return null;
              },
              suffixWidget: IconButton(
                onPressed: () {
                  context.read<ObscureCubit>().toggleConfirmPasswordObscure();
                },
                icon: SvgPicture.asset(
                  obscureState.isConfirmPasswordObscured ? eyeOffIcon : eyeIcon,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    required this.passController,
    super.key,
  });

  final TextEditingController passController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
      builder: (context, state) {
        return BlocBuilder<ObscureCubit, ObscureState>(
          builder: (context, obscureState) {
            return CustomTextField.normal(
              backColor: AppColors.whiteColor,
              borderColor: AppColors.purpleColor,
              nonActiveBorderColor: AppColors.grey5Color,
              textEditingController: passController,
              isObscure: obscureState.isPasswordObscured,
              keyboardType: TextInputType.text,
              labelText:
                  AppLocalization.of(context).getTransatedValues('password') ??
                      '',
              errorText: state.isPassValid
                  ? ''
                  : AppLocalization.of(context)
                          .getTransatedValues('errorPass') ??
                      '',
              suffixWidget: IconButton(
                onPressed: () {
                  context.read<ObscureCubit>().togglePasswordObscure();
                },
                icon: SvgPicture.asset(
                  obscureState.isPasswordObscured ? eyeOffIcon : eyeIcon,
                ),
              ),
              onChanged: (value) {
                context
                    .read<ValidateTextFieldBloc>()
                    .add(PasswordChanged(passWord: value));
                return null;
              },
            );
          },
        );
      },
    );
  }
}

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    required this.phoneController,
    this.readOnly,
    super.key,
  });

  final TextEditingController phoneController;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
      builder: (context, state) {
        return CustomTextField.normal(
          keyboardType: TextInputType.phone,
          inputFormatters: [
            PrefixTextInputFormatter(
              '+993 | ',
              maxLength: 8,
            ),
          ],
          backColor: AppColors.whiteColor,
          borderColor: AppColors.purpleColor,
          nonActiveBorderColor: AppColors.grey5Color,
          labelText:
              AppLocalization.of(context).getTransatedValues('phone') ?? '',
          textEditingController: phoneController,
          errorText: state.isPhoneValid
              ? ''
              : AppLocalization.of(context).getTransatedValues(
                    'errorPhone',
                  ) ??
                  '',
          readOnly: readOnly ?? false,
          onChanged: (value) {
            context
                .read<ValidateTextFieldBloc>()
                .add(PhoneNumberChanged(phoneNumber: value));
            return null;
          },
        );
      },
    );
  }
}
