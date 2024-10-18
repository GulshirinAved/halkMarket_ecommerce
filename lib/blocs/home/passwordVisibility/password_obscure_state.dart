part of 'password_obscure_cubit.dart';

class ObscureState extends Equatable {
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;
  final bool isoldPasswordObscured;

  const ObscureState({
    required this.isPasswordObscured,
    required this.isConfirmPasswordObscured,
    required this.isoldPasswordObscured,
  });

  @override
  List<Object> get props => [
        isPasswordObscured,
        isConfirmPasswordObscured,
        isoldPasswordObscured,
      ];

  ObscureState copyWith({
    bool? isPasswordObscured,
    bool? isConfirmPasswordObscured,
    bool? isoldPasswordObscured,
  }) {
    return ObscureState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isConfirmPasswordObscured:
          isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
      isoldPasswordObscured:
          isoldPasswordObscured ?? this.isoldPasswordObscured,
    );
  }
}
