part of 'save_card_bloc.dart';

sealed class SaveCardEvent extends Equatable {
  const SaveCardEvent();

  @override
  List<Object> get props => [];
}

final class AddCard extends SaveCardEvent {
  final String cardNumber;
  final String username;
  final String expireDate;
  final String cvc;

  const AddCard({
    required this.cardNumber,
    required this.username,
    required this.expireDate,
    required this.cvc,
  });
  @override
  List<Object> get props => [
        cardNumber,
        username,
        expireDate,
        cvc,
      ];
}

final class LoadCard extends SaveCardEvent {
  const LoadCard();
}
