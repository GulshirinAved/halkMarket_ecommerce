import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'save_card_event.dart';
part 'save_card_state.dart';

class SaveCardBloc extends Bloc<SaveCardEvent, SaveCardState> {
  SaveCardBloc() : super(const SaveCardInitial([])) {
    final Box box = Hive.box('cardBox');

    on<AddCard>((event, emit) async {
      final cardList = box.get('cardBox', defaultValue: []) as List;

      final Map<String, dynamic> cardData = {
        'cardNumber': event.cardNumber,
        'userName': event.username,
        'expireDate': event.expireDate,
        'cvc': event.cvc,
      };
      cardList.add(cardData);

      await box.put('cardBox', cardList);

      emit(LoadCardState(cardList));
    });

    on<LoadCard>((event, emit) {
      final cardList = box.get('cardBox', defaultValue: []) as List;
      emit(LoadCardState(cardList));
    });
  }
}
