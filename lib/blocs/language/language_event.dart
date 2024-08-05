part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class InitialLanguageEvent extends LanguageEvent {}

class RussianLanguageEvent extends LanguageEvent {}

class TurkmenLanguageEvent extends LanguageEvent {}
