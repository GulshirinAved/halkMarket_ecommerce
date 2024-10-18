import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/changePass/change_pass_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/forgetPass/forget_pass_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/passwordVisibility/password_obscure_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/forgetPass_content.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ChangepassScreen extends StatefulWidget {
  const ChangepassScreen({super.key});

  @override
  State<ChangepassScreen> createState() => _ChangepassScreenState();
}

class _ChangepassScreenState extends State<ChangepassScreen> {
  late TextEditingController newPassController;
  late TextEditingController repeatPassController;
  late TextEditingController oldPassController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    newPassController = TextEditingController();
    repeatPassController = TextEditingController();
    oldPassController = TextEditingController();
    _pageController = PageController();
  }

  @override
  void dispose() {
    newPassController.dispose();
    repeatPassController.dispose();
    oldPassController.dispose();
    _pageController.dispose();
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
        BlocProvider(
          create: (context) => ForgetPassBloc(),
        ),
        BlocProvider(
          create: (context) => ChangePassBloc(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar.leadingTitle(
          title: AppLocalization.of(context).getTransatedValues('changePass') ??
              '',
          centerTitle: true,
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          children: [
            //change pass content
            ChangePassContent(
              oldPassController: oldPassController,
              newPassController: newPassController,
              repeatPassController: repeatPassController,
              pageController: _pageController,
            ),
            //forget pass content
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: ForgetPassContent(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePassContent extends StatelessWidget {
  const ChangePassContent({
    required this.oldPassController,
    required this.newPassController,
    required this.repeatPassController,
    required this.pageController,
    super.key,
  });

  final TextEditingController oldPassController;
  final TextEditingController newPassController;
  final TextEditingController repeatPassController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              AppLocalization.of(context).getTransatedValues('passLimitDesc') ??
                  '',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.fontSize14,
                color: AppColors.darkPurpleColor,
              ),
            ),
          ),
          //old password
          BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
            builder: (context, validateState) {
              return BlocBuilder<ObscureCubit, ObscureState>(
                builder: (context, state) {
                  return CustomTextField.normal(
                    backColor: AppColors.whiteColor,
                    nonActiveBorderColor: AppColors.grey5Color,
                    borderColor: AppColors.purpleColor,
                    textEditingController: oldPassController,
                    errorText: validateState.isOldPassValid
                        ? ''
                        : AppLocalization.of(context)
                            .getTransatedValues('errorPass'),
                    labelText: AppLocalization.of(context)
                            .getTransatedValues('oldPass') ??
                        '',
                    keyboardType: TextInputType.text,
                    isObscure: state.isoldPasswordObscured,
                    suffixWidget: IconButton(
                      onPressed: () {
                        context.read<ObscureCubit>().toggleoldPasswordObscure();
                      },
                      icon: SvgPicture.asset(
                        state.isoldPasswordObscured ? eyeOffIcon : eyeIcon,
                      ),
                    ),
                    onChanged: (value) {
                      context
                          .read<ValidateTextFieldBloc>()
                          .add(OldPassChanged(oldPass: value));
                      return null;
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          //new  password
          BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
            builder: (context, validateState) {
              return BlocBuilder<ObscureCubit, ObscureState>(
                builder: (context, state) {
                  return CustomTextField.normal(
                    backColor: AppColors.whiteColor,
                    nonActiveBorderColor: AppColors.grey5Color,
                    borderColor: AppColors.purpleColor,
                    textEditingController: newPassController,
                    errorText: validateState.isPassValid
                        ? ''
                        : AppLocalization.of(context)
                            .getTransatedValues('errorPass'),
                    labelText: AppLocalization.of(context)
                            .getTransatedValues('newPass') ??
                        '',
                    keyboardType: TextInputType.text,
                    isObscure: state.isPasswordObscured,
                    suffixWidget: IconButton(
                      onPressed: () {
                        context.read<ObscureCubit>().togglePasswordObscure();
                      },
                      icon: SvgPicture.asset(
                        state.isPasswordObscured ? eyeOffIcon : eyeIcon,
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
          ),
          const SizedBox(
            height: 20,
          ),
          //repeat new pass
          BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
            builder: (context, validateState) {
              return BlocBuilder<ObscureCubit, ObscureState>(
                builder: (context, state) {
                  return CustomTextField.normal(
                    backColor: AppColors.whiteColor,
                    nonActiveBorderColor: AppColors.grey5Color,
                    borderColor: AppColors.purpleColor,
                    isObscure: state.isConfirmPasswordObscured,
                    textEditingController: repeatPassController,
                    labelText: AppLocalization.of(context)
                            .getTransatedValues('repeatPass') ??
                        '',
                    keyboardType: TextInputType.text,
                    errorText: validateState.isVerifyPassValid
                        ? ''
                        : AppLocalization.of(context)
                                .getTransatedValues('errorPass') ??
                            '',
                    suffixWidget: IconButton(
                      onPressed: () {
                        context
                            .read<ObscureCubit>()
                            .toggleConfirmPasswordObscure();
                      },
                      icon: SvgPicture.asset(
                        state.isConfirmPasswordObscured ? eyeOffIcon : eyeIcon,
                      ),
                    ),
                    onChanged: (value) => context
                        .read<ValidateTextFieldBloc>()
                        .add(VerifyPassChanged(verifyPass: value)),
                  );
                },
              );
            },
          ),
          GestureDetector(
            onTap: () {
              pageController.nextPage(
                duration: Durations.short1,
                curve: Curves.bounceIn,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text(
                AppLocalization.of(context).getTransatedValues('forgetPass') ??
                    '',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize14,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            ),
          ),
          BlocListener<ChangePassBloc, ChangePassState>(
            listener: (context, state) {
              if (state is ChangePassLoaded) {
                Animations().snackbar(context, 'successChangedPass');

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  pushScreenWithoutNavBar(
                    context,
                    const BottomNavBar(),
                  );
                });
              } else if (state is ChangePassFailure) {
                Animations().snackbar(context, state.error);
              }
            },
            child: CustomButton.text(
              width: double.infinity,
              backColor: AppColors.purpleColor,
              textColor: AppColors.whiteColor,
              fontSize: AppFonts.fontSize18,
              borderRadius: AppBorders.borderRadius12,
              title: AppLocalization.of(context)
                      .getTransatedValues('saveChanges') ??
                  '',
              onTap: () {
                if (newPassController.text != repeatPassController.text ||
                    newPassController.text.length < 8 ||
                    repeatPassController.text.length < 8 ||
                    oldPassController.text.length < 8 ||
                    newPassController.text == oldPassController.text) {
                  context
                      .read<ValidateTextFieldBloc>()
                      .add(OldPassChanged(oldPass: oldPassController.text));
                  context
                      .read<ValidateTextFieldBloc>()
                      .add(PasswordChanged(passWord: newPassController.text));
                  context.read<ValidateTextFieldBloc>().add(
                        VerifyPassChanged(
                          verifyPass: repeatPassController.text,
                        ),
                      );
                } else {
                  context.read<ChangePassBloc>().add(
                        SubmitChanges(
                          oldPass: oldPassController.text,
                          newPass: newPassController.text,
                        ),
                      );
                }
              },
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}
