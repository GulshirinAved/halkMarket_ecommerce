import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final Box langBox = Hive.box('lang');

  LanguageBloc() : super(const LanguageInitial(languageCode: '')) {
    on<LanguageEvent>((event, emit) {
      if (event is InitialLanguageEvent) {
        if (langBox.get('lang') != null) {
          if (langBox.get('lang') == 'ru') {
            emit(const ChangeLanguageState(languageCode: 'ru'));
          } else {
            emit(const ChangeLanguageState(languageCode: 'tr'));
          }
        }
        if (langBox.get('lang') == null) {
          emit(const ChangeLanguageState(languageCode: 'tr'));
        }
      } else if (event is RussianLanguageEvent) {
        langBox.put('lang', 'ru');

        emit(const ChangeLanguageState(languageCode: 'ru'));
      } else if (event is TurkmenLanguageEvent) {
        langBox.put('lang', 'tr');

        emit(const ChangeLanguageState(languageCode: 'tr'));
      }
    });
  }
}
