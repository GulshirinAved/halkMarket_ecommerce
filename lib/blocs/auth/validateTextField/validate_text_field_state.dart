// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'validate_text_field_bloc.dart';

class ValidateTextFieldState extends Equatable {
  final String phoneNumber;
  final String password;
  final String verifyPass;
  final String oldPass;
  final String birthdayDate;
  final String email;
  final String address;
  final String apartment;
  final String entrance;
  final String floor;
  final String name;
  final String feedback;
  final String cardNumber;
  final String expireDate;
  final String cvc;

  final bool isPhoneValid;
  final bool isPassValid;
  final bool isVerifyPassValid;
  final bool isOldPassValid;
  final bool isVerifyBirthdayValid;
  final bool isVerifyEmailValid;
  final bool isAddressValid;
  final bool isApartmentValid;
  final bool isEntranceValid;
  final bool isFloorValid;
  final bool isNameValid;
  final bool isFeedbackValid;
  final bool isCardNumberValidate;
  final bool isExpireValidate;
  final bool isCvcValidate;

  const ValidateTextFieldState({
    required this.phoneNumber,
    required this.password,
    required this.verifyPass,
    required this.oldPass,
    required this.birthdayDate,
    required this.email,
    required this.address,
    required this.apartment,
    required this.entrance,
    required this.floor,
    required this.name,
    required this.feedback,
    required this.cardNumber,
    required this.expireDate,
    required this.cvc,
    required this.isPhoneValid,
    required this.isPassValid,
    required this.isVerifyPassValid,
    required this.isOldPassValid,
    required this.isVerifyBirthdayValid,
    required this.isVerifyEmailValid,
    required this.isAddressValid,
    required this.isApartmentValid,
    required this.isEntranceValid,
    required this.isFloorValid,
    required this.isNameValid,
    required this.isFeedbackValid,
    required this.isCardNumberValidate,
    required this.isExpireValidate,
    required this.isCvcValidate,
  });
  factory ValidateTextFieldState.initial() {
    return const ValidateTextFieldState(
      phoneNumber: '',
      password: '',
      verifyPass: '',
      birthdayDate: '',
      email: '',
      address: '',
      apartment: '',
      entrance: '',
      floor: '',
      name: '',
      feedback: '',
      oldPass: '',
      cardNumber: '',
      expireDate: '',
      cvc: '',
      isPhoneValid: true,
      isPassValid: true,
      isVerifyPassValid: true,
      isVerifyBirthdayValid: true,
      isVerifyEmailValid: true,
      isAddressValid: true,
      isApartmentValid: true,
      isEntranceValid: true,
      isFloorValid: true,
      isNameValid: true,
      isFeedbackValid: true,
      isOldPassValid: true,
      isCardNumberValidate: true,
      isExpireValidate: true,
      isCvcValidate: true,
    );
  }

  @override
  List<Object> get props => [
        phoneNumber,
        password,
        birthdayDate,
        verifyPass,
        email,
        address,
        apartment,
        entrance,
        floor,
        name,
        feedback,
        oldPass,
        cardNumber,
        expireDate,
        cvc,
        isPhoneValid,
        isPassValid,
        isVerifyPassValid,
        isVerifyBirthdayValid,
        isVerifyEmailValid,
        isAddressValid,
        isApartmentValid,
        isEntranceValid,
        isFloorValid,
        isNameValid,
        isFeedbackValid,
        isOldPassValid,
        isCardNumberValidate,
        isExpireValidate,
        isCvcValidate,
      ];

  ValidateTextFieldState copyWith({
    String? phoneNumber,
    String? password,
    String? verifyPass,
    String? birthdayDate,
    String? email,
    String? address,
    String? apartment,
    String? entrance,
    String? floor,
    String? name,
    String? feedback,
    String? oldPass,
    String? cardNumber,
    String? expireDate,
    String? cvc,
    bool? isPhoneValid,
    bool? isPassValid,
    bool? isVerifyPassValid,
    bool? isVerifyBirthdayValid,
    bool? isVerifyEmailValid,
    bool? isAddressValid,
    bool? isApartmentValid,
    bool? isEntranceValid,
    bool? isFloorValid,
    bool? isNameValid,
    bool? isFeedbackValid,
    bool? isOldPassValid,
    bool? isCardNumberValidate,
    bool? isExpireValidate,
    bool? isCvcValidate,
  }) {
    return ValidateTextFieldState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      verifyPass: verifyPass ?? this.verifyPass,
      birthdayDate: birthdayDate ?? this.birthdayDate,
      email: email ?? this.email,
      address: address ?? this.address,
      apartment: apartment ?? this.apartment,
      entrance: entrance ?? this.entrance,
      floor: floor ?? this.floor,
      name: name ?? this.name,
      oldPass: oldPass ?? this.oldPass,
      feedback: feedback ?? this.feedback,
      cardNumber: cardNumber ?? this.cardNumber,
      expireDate: expireDate ?? this.expireDate,
      cvc: cvc ?? this.cvc,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPassValid: isPassValid ?? this.isPassValid,
      isVerifyPassValid: isVerifyPassValid ?? this.isVerifyPassValid,
      isVerifyBirthdayValid:
          isVerifyBirthdayValid ?? this.isVerifyBirthdayValid,
      isVerifyEmailValid: isVerifyEmailValid ?? this.isVerifyEmailValid,
      isAddressValid: isAddressValid ?? this.isAddressValid,
      isApartmentValid: isApartmentValid ?? this.isApartmentValid,
      isEntranceValid: isEntranceValid ?? this.isEntranceValid,
      isFloorValid: isFloorValid ?? this.isFloorValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isFeedbackValid: isFeedbackValid ?? this.isFeedbackValid,
      isOldPassValid: isOldPassValid ?? this.isOldPassValid,
      isCardNumberValidate: isCardNumberValidate ?? this.isCardNumberValidate,
      isExpireValidate: isExpireValidate ?? this.isExpireValidate,
      isCvcValidate: isCvcValidate ?? this.isCvcValidate,
    );
  }
}
