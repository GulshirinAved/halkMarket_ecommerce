import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/profile/savePaymentCard/save_card_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/extension.dart';

class PayMethodProfileScreen extends StatefulWidget {
  const PayMethodProfileScreen({super.key});

  @override
  State<PayMethodProfileScreen> createState() => _PayMethodProfileScreenState();
}

class _PayMethodProfileScreenState extends State<PayMethodProfileScreen> {
  late TextEditingController cardNumberController;
  late TextEditingController nameController;
  late TextEditingController expireDateController;
  late TextEditingController cvcController;
  @override
  void initState() {
    super.initState();
    cardNumberController = TextEditingController();
    nameController = TextEditingController();
    expireDateController = TextEditingController();
    cvcController = TextEditingController();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    nameController.dispose();
    expireDateController.dispose();
    cvcController.dispose();
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
          create: (context) => SaveCardBloc(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar.leadingTitle(
              title:
                  AppLocalization.of(context).getTransatedValues('payMethod') ??
                      '',
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.whiteColor,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          builder: (
                            BuildContext context,
                            ScrollController scrollController,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            AppLocalization.of(context)
                                                    .getTransatedValues(
                                                  'whatIsCvc',
                                                ) ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.darkPurpleColor,
                                              fontFamily: fontExo2,
                                              fontSize: AppFonts.fontSize18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(closeIcon),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView(
                                      shrinkWrap: true,
                                      controller: scrollController,
                                      children: [
                                        Text(
                                          AppLocalization.of(context)
                                                  .getTransatedValues(
                                                'howToKnowCvc',
                                              ) ??
                                              '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: AppFonts.fontSize16,
                                          ),
                                        ),
                                        Text(
                                          '''
                                                                  Оплата услуг и покупок товаров онлайн с помощью карты «Алтын Асыр», необходим специальный CVC-код (Card
                                                                  Validation Code).Он напечатан на оборотной стороне карты и состоит из трех цифр как показано на фото.Получить CVC-код для карт «Алтын Асыр» можно в любом банкомате Туркменистана, в том числе в банкоматах
                                                                  возле головного офиса "Халк Банк" по ул. Худайбердиева, г. Ашхабад. Инструкцию по запросу CVC-кода с
                                                                  помощью банкомата Вы можете скачать тут или воспользоватся инструкцией ниже.сли по техническим причинам Вы не смогли получить код то Вы можете обратиться в банк где обслуживается
                                                                  Ваша карта.Инструкция по созданию заявки на получение CVC-кода в банкомате.Внимание: При формировании запроса на CVC-код у пользователя уже должна быть оформлена подписка на
                                                                  услугу «СМС-оповещение»После успешной авторизации на экране банкомата появляется картинка с меню доступных операций. Выбираем
                                                                  пункт меню «Платежи»;Далее выбираем пункт меню «Телефон»;
                                                                  В следующем окне выбираем пункт меню «CVC kod»;На следующем шаге вводим номер телефона, который Вы указали при оформлении подписки на СМС-оповещение.
                                                                  На него и поступит СVC-код.Если Вы указали правильный номер телефона, то система выдаст следующее сообщение:
                                                                  Убедитесь еще раз, что введенные данные верны и подтвердите его.
                                                                  
                                                                  
                                                                  ''',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: AppFonts.fontSize16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: SvgPicture.asset(infoIcon),
                ),
              ],
              needBoxshadow: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //card number field
                          BlocBuilder<ValidateTextFieldBloc,
                              ValidateTextFieldState>(
                            builder: (context, state) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: CustomTextField.normal(
                                  backColor: AppColors.whiteColor,
                                  nonActiveBorderColor: AppColors.grey5Color,
                                  borderColor: AppColors.purpleColor,
                                  textEditingController: cardNumberController,
                                  inputFormatters: [
                                    SpaceInputFormatter(),
                                    LengthLimitingTextInputFormatter(19),
                                  ],
                                  hintText: 'xxxx xxxx xxxx xxxx',
                                  errorText: state.isCardNumberValidate
                                      ? ''
                                      : AppLocalization.of(context)
                                              .getTransatedValues(
                                            'cardError',
                                          ) ??
                                          '',
                                  maxLine: 1,
                                  labelText: AppLocalization.of(context)
                                          .getTransatedValues(
                                        'cardNumber',
                                      ) ??
                                      '',
                                  keyboardType: TextInputType.number,
                                  suffixWidget: IconButton(
                                    onPressed: () {
                                      cardNumberController.clear();
                                    },
                                    icon: SvgPicture.asset(closeIcon),
                                  ),
                                  onChanged: (value) => context
                                      .read<ValidateTextFieldBloc>()
                                      .add(
                                        CardNumberValidate(cardNumber: value),
                                      ),
                                ),
                              );
                            },
                          ),

                          //name field
                          BlocBuilder<ValidateTextFieldBloc,
                              ValidateTextFieldState>(
                            builder: (context, state) {
                              return CustomTextField.normal(
                                backColor: AppColors.whiteColor,
                                nonActiveBorderColor: AppColors.grey5Color,
                                borderColor: AppColors.purpleColor,
                                textEditingController: nameController,
                                hintText: 'Например: Мырат',
                                errorText: state.isNameValid
                                    ? ''
                                    : AppLocalization.of(context)
                                            .getTransatedValues(
                                          'cardError',
                                        ) ??
                                        '',
                                labelText: AppLocalization.of(context)
                                        .getTransatedValues(
                                      'nameSurname',
                                    ) ??
                                    '',
                                keyboardType: TextInputType.text,
                                suffixWidget: IconButton(
                                  onPressed: () {
                                    nameController.clear();
                                  },
                                  icon: SvgPicture.asset(closeIcon),
                                ),
                                onChanged: (value) =>
                                    context.read<ValidateTextFieldBloc>().add(
                                          NameChanged(name: value),
                                        ),
                              );
                            },
                          ),
                          //expire date field
                          BlocBuilder<ValidateTextFieldBloc,
                              ValidateTextFieldState>(
                            builder: (context, state) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: CustomTextField.normal(
                                  backColor: AppColors.whiteColor,
                                  nonActiveBorderColor: AppColors.grey5Color,
                                  borderColor: AppColors.purpleColor,
                                  textEditingController: expireDateController,
                                  hintText: '** / **',
                                  inputFormatters: [
                                    SlashInputFormatter(),
                                    LengthLimitingTextInputFormatter(7),
                                  ],
                                  errorText: state.isExpireValidate
                                      ? ''
                                      : AppLocalization.of(context)
                                              .getTransatedValues(
                                            'fillCorrectly',
                                          ) ??
                                          '',
                                  labelText: AppLocalization.of(context)
                                          .getTransatedValues(
                                        'cardExpireDate',
                                      ) ??
                                      '',
                                  suffixWidget: IconButton(
                                    onPressed: () {
                                      expireDateController.clear();
                                    },
                                    icon: SvgPicture.asset(closeIcon),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => context
                                      .read<ValidateTextFieldBloc>()
                                      .add(
                                        ExpireDateValidate(expireDate: value),
                                      ),
                                ),
                              );
                            },
                          ),

                          //cvc field
                          BlocBuilder<ValidateTextFieldBloc,
                              ValidateTextFieldState>(
                            builder: (context, state) {
                              return CustomTextField.normal(
                                backColor: AppColors.whiteColor,
                                nonActiveBorderColor: AppColors.grey5Color,
                                borderColor: AppColors.purpleColor,
                                textEditingController: cvcController,
                                hintText: '***',
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                errorText: state.isCvcValidate
                                    ? ''
                                    : AppLocalization.of(context)
                                            .getTransatedValues(
                                          'fillCorrectly',
                                        ) ??
                                        '',
                                labelText: 'CVC',
                                keyboardType: TextInputType.number,
                                onChanged: (value) =>
                                    context.read<ValidateTextFieldBloc>().add(
                                          CvcValidate(cvc: value),
                                        ),
                              );
                            },
                          ),
                          //card
                          Container(
                            height: 195,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: AppBorders.borderRadius12,
                              image: const DecorationImage(
                                image: AssetImage(
                                  cardBg,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(cpuIcon),
                                ValueListenableBuilder(
                                  valueListenable: cardNumberController,
                                  builder:
                                      (context, TextEditingValue value, __) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        top: 30,
                                        bottom: 43,
                                      ),
                                      child: Text(
                                        formatCardNumber(value.text),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: AppFonts.fontSize18,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: nameController,
                                      builder: (context, value, child) => Text(
                                        nameController.text.isEmpty
                                            ? 'xxxxxxxxxxxxxx'
                                            : nameController.text.toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: AppFonts.fontSize16,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: expireDateController,
                                      builder: (
                                        context,
                                        TextEditingValue value,
                                        __,
                                      ) {
                                        return Text(
                                          expireDateController.text.isEmpty
                                              ? 'xx/xx'
                                              : formatExpireDate(value.text),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: AppFonts.fontSize16,
                                            color: AppColors.whiteColor,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).withText(
                        context,
                        topTitle: 'cardDetails',
                        fontSize: AppFonts.fontSize18,
                        fontweight: FontWeight.w600,
                        textColor: AppColors.darkPurpleColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomButton.withIconText(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      borderRadius: AppBorders.borderRadius12,
                      width: MediaQuery.of(context).size.width,
                      backColor: AppColors.purpleColor,
                      textColor: AppColors.whiteColor,
                      fontSize: AppFonts.fontSize16,
                      title: AppLocalization.of(context)
                              .getTransatedValues('addCard') ??
                          '',
                      fontweight: FontWeight.w400,
                      onTap: () {
                        if (cardNumberController.text.length == 19 &&
                            nameController.text.isNotEmpty &&
                            expireDateController.text.length == 7 &&
                            cvcController.text.length == 3) {
                          context.read<SaveCardBloc>().add(
                                AddCard(
                                  cardNumber: cardNumberController.text,
                                  username: nameController.text,
                                  expireDate: expireDateController.text,
                                  cvc: cvcController.text,
                                ),
                              );
                          context.read<SaveCardBloc>().add(
                                const LoadCard(),
                              );
                          Navigator.pop(context);
                        } else {
                          context.read<ValidateTextFieldBloc>().add(
                                CardNumberValidate(
                                  cardNumber: cardNumberController.text,
                                ),
                              );
                          context.read<ValidateTextFieldBloc>().add(
                                NameChanged(
                                  name: nameController.text,
                                ),
                              );
                          context.read<ValidateTextFieldBloc>().add(
                                ExpireDateValidate(
                                  expireDate: expireDateController.text,
                                ),
                              );
                          context.read<ValidateTextFieldBloc>().add(
                                CvcValidate(
                                  cvc: cvcController.text,
                                ),
                              );
                        }
                      },
                      icon: addCardIcon,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

String formatCardNumber(String cardNumber) {
  final String paddedCardNumber = cardNumber.padRight(16, 'X');
  final buffer = StringBuffer();
  for (int i = 0; i < paddedCardNumber.length; i++) {
    buffer.write(paddedCardNumber[i]);
    if ((i + 1) % 4 == 0 && i + 1 != paddedCardNumber.length) {
      buffer.write(' ');
    }
  }

  return buffer.toString();
}

String formatExpireDate(String expireDate) {
  final text = expireDate.replaceAll('/', '');
  final buffer = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    if (i == 2) {
      buffer.write(' /');
    }
    buffer.write(text[i]);
  }
  return buffer.toString();
}
