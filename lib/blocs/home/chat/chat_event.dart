part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetRoomMessages extends ChatEvent {
  const GetRoomMessages();
}

class SendMessage extends ChatEvent {
  final String text;
  final String attachment;
  final String author;

  const SendMessage({
    required this.text,
    required this.attachment,
    required this.author,
  });
  @override
  List<Object> get props => [text, attachment, author];
}

class NewMessageReceived extends ChatEvent {
  final Map<String, dynamic> message;
  const NewMessageReceived(this.message);
  @override
  List<Object> get props => [message];
}

class MessagesUpdated extends ChatEvent {
  final List<Map<String, dynamic>> updatedMessages;

  const MessagesUpdated(this.updatedMessages);
}
