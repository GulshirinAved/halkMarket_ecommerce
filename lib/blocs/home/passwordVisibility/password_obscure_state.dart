part of 'password_obscure_cubit.dart';

class ObscureState extends Equatable {
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;

  const ObscureState({
    required this.isPasswordObscured,
    required this.isConfirmPasswordObscured,
  });

  @override
  List<Object> get props => [isPasswordObscured, isConfirmPasswordObscured];

  ObscureState copyWith({
    bool? isPasswordObscured,
    bool? isConfirmPasswordObscured,
  }) {
    return ObscureState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isConfirmPasswordObscured:
          isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
    );
  }
}
