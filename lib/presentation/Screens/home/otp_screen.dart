import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/otp/otp_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/saveOtpInput/save_otp_input_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/timer/timer_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({
    required this.phoneNumber,
    super.key,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  late OtpBloc otpBloc;
  late TimerBloc timerBloc;
  late SaveOtpInputBloc saveOtpInputBloc;

  @override
  void initState() {
    super.initState();
    otpBloc = OtpBloc();
    timerBloc = TimerBloc();
    saveOtpInputBloc = SaveOtpInputBloc();
    timerBloc.add(StartTimer());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    otpBloc.close();
    timerBloc.close();
    saveOtpInputBloc.close();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OtpBloc>.value(
          value: otpBloc,
        ),
        BlocProvider<TimerBloc>.value(
          value: timerBloc,
        ),
        BlocProvider<SaveOtpInputBloc>.value(
          value: saveOtpInputBloc,
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar.leadingTitle(
          title:
              AppLocalization.of(context).getTransatedValues('profile') ?? '',
          centerTitle: false,
          leadingWidth: 20,
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
            Image.asset(
              halkMarketImage,
              alignment: Alignment.topCenter,
            ),
            Text(
              AppLocalization.of(context).getTransatedValues('writeCode') ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppFonts.fontSize24,
                color: AppColors.darkPurpleColor,
              ),
            ),
            Text(
              '${AppLocalization.of(context).getTransatedValues('descWriteCode') ?? ''} +993${widget.phoneNumber}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.fontSize15,
                color: AppColors.darkPurpleColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                controllers.length,
                (index) => Container(
                  width: 56,
                  height: 50,
                  margin: const EdgeInsets.only(right: 11, top: 10),
                  child: CustomTextField.normal(
                    hintText: '',
                    rangeNumber: 1,
                    keyboardType: TextInputType.number,
                    textEditingController: controllers[index],
                    textAlign: TextAlign.center,
                    focusNode: focusNodes[index],
                    errorText: null,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        if (index < controllers.length - 1) {
                          FocusScope.of(context)
                              .requestFocus(focusNodes[index + 1]);
                        } else {
                          focusNodes[index].unfocus();
                        }
                        saveOtpInputBloc.add(AddCodeEvent(otpCode: value));
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context)
                            .requestFocus(focusNodes[index - 1]);
                        saveOtpInputBloc.add(RemoveCodeEvent(otpCode: value));
                      }
                    },
                    onFieldSubmitted: (value) {
                      if (index < controllers.length - 1) {
                        FocusScope.of(context)
                            .requestFocus(focusNodes[index + 1]);
                      } else {
                        focusNodes[index].unfocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            BlocListener<OtpBloc, OtpState>(
              listener: (context, state) {
                if (state is OtpFailure) {
                  Animations().snackbar(
                    context,
                    state.statusCode == 602
                        ? 'userExists'
                        : state.statusCode == 603
                            ? 'otpinvalid'
                            : 'error',
                  );
                } else if (state is OtpSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    pushReplacementWithNavBar(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                    );
                  });
                }
              },
              child: BlocBuilder<SaveOtpInputBloc, SaveOtpInputState>(
                builder: (context, inputState) {
                  return BlocBuilder<OtpBloc, OtpState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
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
                            if (inputState.otpCode!.length != 4) {
                              Animations().snackbar(
                                context,
                                'mustBeFour',
                              );
                            } else {
                              otpBloc.add(
                                SendOtp(
                                  '+993${widget.phoneNumber}',
                                  int.parse(inputState.otpCode ?? ''),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                String timerText;
                if (state is TimerRunning) {
                  timerText = _formatDuration(state.remainingTime);
                } else if (state is TimerFinished) {
                  timerText = '00:00';
                } else {
                  timerText = '05:00';
                }
                return GestureDetector(
                  onTap: () {
                    timerBloc.add(StartTimer());
                  },
                  child: Text.rich(
                    maxLines: 2,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalization.of(context)
                                  .getTransatedValues('resend') ??
                              '',
                          style: TextStyle(
                            color: timerText == '00:00'
                                ? AppColors.redColor
                                : AppColors.darkPurpleColor,
                            fontWeight: FontWeight.w400,
                            fontSize: AppFonts.fontSize14,
                          ),
                        ),
                        TextSpan(
                          text: ' $timerText',
                          style: TextStyle(
                            color: AppColors.purpleColor,
                            fontWeight: FontWeight.w400,
                            fontSize: AppFonts.fontSize14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
