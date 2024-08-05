part of 'language_bloc.dart';

sealed class LanguageState extends Equatable {
  final String languageCode;
  const LanguageState({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}

final class LanguageInitial extends LanguageState {
  const LanguageInitial({required super.languageCode});
}

class ChangeLanguageState extends LanguageState {
  const ChangeLanguageState({required super.languageCode});
}
