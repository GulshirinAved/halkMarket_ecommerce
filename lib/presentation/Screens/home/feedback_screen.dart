import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/userProfile/user_profile_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/passwordVisibility/password_obscure_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/profile/createFeedback/create_feedback_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/login_screen.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController messageController;
  late UserProfileBloc _userProfileBloc;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController(text: '+993 | ');
    messageController = TextEditingController();
    _userProfileBloc = UserProfileBloc()..add(GetUserData());
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    messageController.dispose();
    _userProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ValidateTextFieldBloc()),
        BlocProvider(create: (context) => ObscureCubit()),
        BlocProvider(create: (context) => CreateFeedbackBloc()),
        BlocProvider.value(value: _userProfileBloc),
      ],
      child: BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileLoaded) {
            final userData = state.userData;
            phoneController.text = userData.phone ?? '';
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: CustomAppBar.leadingTitle(
                title: AppLocalization.of(context)
                        .getTransatedValues('feedback') ??
                    '',
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
// Name field
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return CustomTextField.normal(
                          backColor: AppColors.whiteColor,
                          nonActiveBorderColor: AppColors.grey5Color,
                          borderColor: AppColors.purpleColor,
                          textEditingController: nameController,
                          errorText: state.isNameValid
                              ? ''
                              : AppLocalization.of(context)
                                      .getTransatedValues('fillError') ??
                                  '',
                          maxLine: 1,
                          labelText: AppLocalization.of(context)
                                  .getTransatedValues('fullName') ??
                              '',
                          keyboardType: TextInputType.text,
                          onChanged: (value) => context
                              .read<ValidateTextFieldBloc>()
                              .add(NameChanged(name: value)),
                        );
                      },
                    ),
// Phone field
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        return PhoneTextField(
                          phoneController: phoneController,
                          readOnly: state is UserProfileLoaded &&
                              state.userData.phone != '',
                        );
                      },
                    ),
// Message field
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return CustomTextField.normal(
                          backColor: AppColors.whiteColor,
                          nonActiveBorderColor: AppColors.grey5Color,
                          borderColor: AppColors.purpleColor,
                          textEditingController: messageController,
                          errorText: state.isFeedbackValid
                              ? ''
                              : AppLocalization.of(context)
                                      .getTransatedValues('fillError') ??
                                  '',
                          maxLine: 3,
                          suffixWidget: null,
                          labelText: AppLocalization.of(context)
                                  .getTransatedValues('message') ??
                              '',
                          keyboardType: TextInputType.text,
                          onChanged: (value) => context
                              .read<ValidateTextFieldBloc>()
                              .add(FeedbackValidate(feedback: value)),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, userState) {
                        return BlocListener<CreateFeedbackBloc,
                            CreateFeedbackState>(
                          listener: (context, state) {
                            log(state.toString());
                            if (state is CreateFeedbackSuccess) {
                              Animations().snackbar(context, 'sendSuccess');
                              Navigator.pop(context);
                            } else if (state is CreateFeedbackError) {
                              Animations().snackbar(context, 'error');
                            }
                          },
                          child: CustomButton.text(
                            width: double.infinity,
                            backColor: AppColors.purpleColor,
                            textColor: AppColors.whiteColor,
                            fontSize: AppFonts.fontSize18,
                            title: AppLocalization.of(context)
                                    .getTransatedValues('send') ??
                                '',
                            onTap: () {
                              final String phone = phoneController.text
                                  .replaceFirst('+993 | ', '');

                              final bool isPhoneValid =
                                  AuthProvider().getAccessToken() == null
                                      ? phone.length == 8
                                      : phone.length == 12;

                              if (nameController.text.isEmpty ||
                                  messageController.text.isEmpty ||
                                  !isPhoneValid) {
                                context.read<ValidateTextFieldBloc>().add(
                                      NameChanged(name: nameController.text),
                                    );
                                context.read<ValidateTextFieldBloc>().add(
                                      FeedbackValidate(
                                        feedback: messageController.text,
                                      ),
                                    );
                              } else {
                                final String formattedPhone =
                                    phone.length == 12 ? phone : '+993$phone';

                                context.read<CreateFeedbackBloc>().add(
                                      SendMessage(
                                        name: nameController.text,
                                        phone: formattedPhone,
                                        message: messageController.text,
                                      ),
                                    );
                              }
                            },
                            borderRadius: AppBorders.borderRadius12,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
