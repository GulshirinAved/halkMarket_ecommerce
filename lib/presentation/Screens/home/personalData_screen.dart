import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/updateUserData/update_user_data_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/userProfile/user_profile_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/selectCard/select_card_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/selection_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/login_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  late TextEditingController nameSurnameController;
  late TextEditingController phoneController;
  late TextEditingController dateController;
  late TextEditingController emailController;
  late TextEditingController birthdayController;
  late UserProfileBloc _userProfileBloc;
  late SelectCardCubit _genderCubit;

  @override
  void initState() {
    super.initState();
    _genderCubit = SelectCardCubit();
    nameSurnameController = TextEditingController();
    phoneController = TextEditingController(text: '+993 | ');
    emailController = TextEditingController();
    birthdayController = TextEditingController();
    _userProfileBloc = UserProfileBloc()..add(GetUserData());
  }

  @override
  void dispose() {
    _genderCubit.close();
    nameSurnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    birthdayController.dispose();
    _userProfileBloc.close();
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
          create: (context) => UpdateUserDataBloc(),
        ),
        BlocProvider.value(
          value: _userProfileBloc,
        ),
        BlocProvider.value(
          value: _genderCubit,
        ),
      ],
      child: BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileLoaded) {
            final userData = state.userData;
            nameSurnameController.text = userData.name ?? '';
            phoneController.text = userData.phone ?? '';
            emailController.text = userData.email ?? '';
            final DateTime parsedDate =
                DateTime.parse(userData.birthday.toString());
            final String formattedDate =
                DateFormat('yyyy-MM-dd').format(parsedDate);
            birthdayController.text = formattedDate;
            context
                .read<SelectCardCubit>()
                .selectCard(index: userData.gender == 'male' ? 0 : 1);
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: CustomAppBar.leadingTitle(
                title: AppLocalization.of(context)
                        .getTransatedValues('privateData') ??
                    '',
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    //name surname
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return CustomTextField.normal(
                          backColor: AppColors.whiteColor,
                          borderColor: AppColors.purpleColor,
                          nonActiveBorderColor: AppColors.grey5Color,
                          errorText: state.isNameValid
                              ? ''
                              : AppLocalization.of(context).getTransatedValues(
                                    'fillError',
                                  ) ??
                                  '',
                          textEditingController: nameSurnameController,
                          labelText: AppLocalization.of(context)
                                  .getTransatedValues('nameSurname') ??
                              '',
                          onChanged: (value) => context
                              .read<ValidateTextFieldBloc>()
                              .add(NameChanged(name: value)),
                          keyboardType: TextInputType.name,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    //phone field
                    PhoneTextField(
                      phoneController: phoneController,
                      readOnly: true,
                    ),
                    //gender selection cards
                    SelectionCard(
                      optionList: genderList,
                    ),

                    //email textfield
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return CustomTextField.normal(
                          backColor: AppColors.whiteColor,
                          borderColor: AppColors.purpleColor,
                          nonActiveBorderColor: AppColors.grey5Color,
                          errorText: state.isVerifyEmailValid
                              ? ''
                              : AppLocalization.of(context).getTransatedValues(
                                    'emailError',
                                  ) ??
                                  '',
                          textEditingController: emailController,
                          labelText: AppLocalization.of(context)
                                  .getTransatedValues('email') ??
                              '',
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            context
                                .read<ValidateTextFieldBloc>()
                                .add(EmailChanged(email: value));
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                      builder: (context, state) {
                        return CustomTextField.normal(
                          backColor: AppColors.whiteColor,
                          borderColor: AppColors.purpleColor,
                          nonActiveBorderColor: AppColors.grey5Color,
                          errorText: state.isVerifyBirthdayValid
                              ? ''
                              : AppLocalization.of(context).getTransatedValues(
                                    'birthdayError',
                                  ) ??
                                  '',
                          textEditingController: birthdayController,
                          labelText: AppLocalization.of(context)
                                  .getTransatedValues('birthday') ??
                              '',
                          hintText: 'year-mm-dd',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d{0,4}-?\d{0,2}-?\d{0,2}'),
                            ),
                            BirthdayFormatter(),
                          ],
                          onChanged: (value) {
                            context
                                .read<ValidateTextFieldBloc>()
                                .add(BirthdayChanged(birthdayDate: value));
                          },
                        );
                      },
                    ),
                    BlocListener<UpdateUserDataBloc, UpdateUserDataState>(
                      listener: (context, state) {
                        if (state is UpdateUserDataFailure) {
                          Animations().snackbar(
                            context,
                            'error',
                          );
                        } else if (state is UpdateUserDataLoaded) {
                          pushReplacementWithoutNavBar(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<SelectCardCubit, int>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: CustomButton.text(
                              borderRadius: AppBorders.borderRadius12,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                top: 14,
                                bottom: 16,
                              ),
                              backColor: AppColors.purpleColor,
                              textColor: AppColors.whiteColor,
                              fontSize: AppFonts.fontSize18,
                              title: AppLocalization.of(context)
                                      .getTransatedValues('saveChanges') ??
                                  '',
                              onTap: () {
                                if (emailController.text.isEmpty ||
                                    nameSurnameController.text.isEmpty) {
                                  context.read<ValidateTextFieldBloc>().add(
                                        NameChanged(
                                          name: nameSurnameController.text,
                                        ),
                                      );
                                  context.read<ValidateTextFieldBloc>().add(
                                        EmailChanged(
                                          email: emailController.text,
                                        ),
                                      );
                                } else {
                                  context.read<UpdateUserDataBloc>().add(
                                        UpdateUserDataSubmitted(
                                          name: nameSurnameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          birthday: birthdayController.text,
                                          gender: genderList[state],
                                        ),
                                      );
                                }
                              },
                            ),
                          );
                        },
                      ),
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
