part of 'validate_text_field_bloc.dart';

sealed class ValidateTextFieldEvent extends Equatable {
  const ValidateTextFieldEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends ValidateTextFieldEvent {
  final String phoneNumber;

  const PhoneNumberChanged({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}

class PasswordChanged extends ValidateTextFieldEvent {
  final String passWord;

  const PasswordChanged({required this.passWord});
  @override
  List<Object> get props => [passWord];
}

class VerifyPassChanged extends ValidateTextFieldEvent {
  final String verifyPass;

  const VerifyPassChanged({required this.verifyPass});
  @override
  List<Object> get props => [verifyPass];
}

class VerifyNewPassChanged extends ValidateTextFieldEvent {
  final String verifyNewPass;

  const VerifyNewPassChanged({required this.verifyNewPass});
  @override
  List<Object> get props => [verifyNewPass];
}

class OldPassChanged extends ValidateTextFieldEvent {
  final String oldPass;

  const OldPassChanged({required this.oldPass});
  @override
  List<Object> get props => [oldPass];
}

class BirthdayChanged extends ValidateTextFieldEvent {
  final String birthdayDate;

  const BirthdayChanged({required this.birthdayDate});
  @override
  List<Object> get props => [birthdayDate];
}

class EmailChanged extends ValidateTextFieldEvent {
  final String email;

  const EmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}

class AddressChanged extends ValidateTextFieldEvent {
  final String address;

  const AddressChanged({required this.address});
  @override
  List<Object> get props => [address];
}

class ApartmentChanged extends ValidateTextFieldEvent {
  final String apartment;

  const ApartmentChanged({required this.apartment});
  @override
  List<Object> get props => [apartment];
}

class EntranceChanged extends ValidateTextFieldEvent {
  final String entrance;

  const EntranceChanged({required this.entrance});
  @override
  List<Object> get props => [entrance];
}

class FloorChanged extends ValidateTextFieldEvent {
  final String floor;

  const FloorChanged({required this.floor});
  @override
  List<Object> get props => [floor];
}

class NameChanged extends ValidateTextFieldEvent {
  final String name;

  const NameChanged({required this.name});
  @override
  List<Object> get props => [name];
}

class FeedbackValidate extends ValidateTextFieldEvent {
  final String feedback;

  const FeedbackValidate({required this.feedback});
  @override
  List<Object> get props => [feedback];
}

class CardNumberValidate extends ValidateTextFieldEvent {
  final String cardNumber;

  const CardNumberValidate({required this.cardNumber});
  @override
  List<Object> get props => [cardNumber];
}

class ExpireDateValidate extends ValidateTextFieldEvent {
  final String expireDate;

  const ExpireDateValidate({required this.expireDate});
  @override
  List<Object> get props => [expireDate];
}

class CvcValidate extends ValidateTextFieldEvent {
  final String cvc;

  const CvcValidate({required this.cvc});
  @override
  List<Object> get props => [cvc];
}
