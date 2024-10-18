import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'validate_text_field_event.dart';
part 'validate_text_field_state.dart';

class ValidateTextFieldBloc
    extends Bloc<ValidateTextFieldEvent, ValidateTextFieldState> {
  ValidateTextFieldBloc() : super(ValidateTextFieldState.initial()) {
    on<PhoneNumberChanged>((event, emit) {
      final isValid = event.phoneNumber.length == 15 &&
          event.phoneNumber.startsWith('+993 | 6');

      emit(
        state.copyWith(
          phoneNumber: event.phoneNumber,
          isPhoneValid: isValid,
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      final isValid = event.passWord.length >= 8;
      emit(
        state.copyWith(
          password: event.passWord,
          isPassValid: isValid,
        ),
      );
    });

    on<VerifyPassChanged>((event, emit) {
      final isValid = event.verifyPass.trim() == state.password.trim();

      emit(
        state.copyWith(
          verifyPass: event.verifyPass,
          isVerifyPassValid: isValid,
        ),
      );
    });
    on<OldPassChanged>((event, emit) {
      final isValid = event.oldPass.trim() != state.password.trim() ||
          event.oldPass.isNotEmpty ||
          event.oldPass.length >= 8;

      emit(
        state.copyWith(
          oldPass: event.oldPass,
          isOldPassValid: isValid,
        ),
      );
    });
    on<BirthdayChanged>((event, emit) {
      try {
        final DateTime date =
            DateFormat('yyyy-MM-dd').parseStrict(event.birthdayDate);
        bool isValid = date.year <= 2011 && date.month <= 12;
        if (isValid) {
          if (date.month == 2) {
// Check for leap year
            final bool isLeapYear =
                (date.year % 4 == 0 && date.year % 100 != 0) ||
                    (date.year % 400 == 0);
            isValid = isLeapYear ? date.day <= 29 : date.day <= 28;
          } else if ([4, 6, 9, 11].contains(date.month)) {
// April, June, September, November have 30 days
            isValid = date.day <= 30;
          } else {
// Other months have 31 days
            isValid = date.day <= 31;
          }
        }

        emit(
          state.copyWith(
            isVerifyBirthdayValid: isValid,
            birthdayDate: event.birthdayDate,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            isVerifyBirthdayValid: false,
            birthdayDate: event.birthdayDate,
          ),
        );
      }
    });

    on<EmailChanged>((event, emit) {
      final bool isValid = event.email.endsWith('@gmail.com');
      emit(
        state.copyWith(
          isVerifyEmailValid: isValid,
          email: event.email,
        ),
      );
    });
    on<AddressChanged>((event, emit) {
      final bool isValid = event.address.isNotEmpty;
      emit(
        state.copyWith(
          isAddressValid: isValid,
          address: event.address,
        ),
      );
    });
    on<ApartmentChanged>((event, emit) {
      final bool isValid = event.apartment.isNotEmpty;
      emit(
        state.copyWith(
          isApartmentValid: isValid,
          apartment: event.apartment,
        ),
      );
    });
    on<EntranceChanged>((event, emit) {
      final bool isValid = event.entrance.isNotEmpty;
      emit(
        state.copyWith(
          isEntranceValid: isValid,
          entrance: event.entrance,
        ),
      );
    });
    on<FloorChanged>((event, emit) {
      final bool isValid = event.floor.isNotEmpty;
      emit(
        state.copyWith(
          isFloorValid: isValid,
          floor: event.floor,
        ),
      );
    });
    on<NameChanged>((event, emit) {
      final bool isValid = event.name.isNotEmpty;
      emit(
        state.copyWith(
          isNameValid: isValid,
          name: event.name,
        ),
      );
    });
    on<FeedbackValidate>((event, emit) {
      final bool isValid = event.feedback.isNotEmpty;
      emit(
        state.copyWith(
          isFeedbackValid: isValid,
          feedback: event.feedback,
        ),
      );
    });
    on<CardNumberValidate>((event, emit) {
      final bool isValid = event.cardNumber.length == 19;
      emit(
        state.copyWith(
          isCardNumberValidate: isValid,
          cardNumber: event.cardNumber,
        ),
      );
    });
    on<ExpireDateValidate>((event, emit) {
      final bool isValid = event.expireDate.length == 7;
      emit(
        state.copyWith(
          isExpireValidate: isValid,
          expireDate: event.expireDate,
        ),
      );
    });
    on<CvcValidate>((event, emit) {
      final bool isValid = event.cvc.length == 3;
      emit(
        state.copyWith(
          isCvcValidate: isValid,
          cvc: event.cvc,
        ),
      );
    });
  }
}
