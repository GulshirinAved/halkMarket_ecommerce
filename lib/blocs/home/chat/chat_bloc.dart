import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/api_providers/websocket_provider.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  String? roomId;
  final List<Map<String, dynamic>> messages = [];

  ChatBloc() : super(ChatInitial()) {
    final WebSocketService webSocketService = WebSocketService(
      Endpoints().webSocketUrl,
      AuthProvider().getAccessToken() ?? '',
    );
    _connectWebSocket(webSocketService);

    on<GetRoomMessages>((event, emit) async {
      try {
        // Check if the access token is available
        final String? accessToken = AuthProvider().getAccessToken();

        if (accessToken == null || accessToken.isEmpty) {
          // If there's no access token, get the device ID asynchronously
          roomId = await AuthProvider().getDeviceId();
        } else {
          // If access token exists, fetch the user profile asynchronously
          final userProfile = await AuthProvider().getUserProfile();
          roomId =
              userProfile.id; // Assuming userProfile has a field called 'id'
        }

        if (roomId == null) {
          emit(const ChatError('Unable to retrieve user or device ID.'));
          return;
        }

        // Send WebSocket request to find messages for the user/device
        final request = {
          'event': 'findOneChat',
          'data': {
            'id': roomId,
          },
        };

        webSocketService.sendMessage(request);
        log('Requesting messages for id: $roomId');
        emit(ChatLoading()); // Emit loading state while fetching messages
      } catch (e) {
        emit(ChatError('Failed to fetch messages: $e'));
      }
    });

    on<SendMessage>((event, emit) {
      if (roomId == null) {
        emit(const ChatError('Room ID is not set yet.'));
        return;
      }

      final message = {
        'text': event.text,
        'attachment': event.attachment,
        'type': '',
        'author': event.author,
        'roomId': roomId,
      };

      messages.insert(0, message);
      log(messages.toString());
      emit(ChatLoaded(messages: List.from(messages))); // Emit updated state

      final wsMessage = {
        'event': 'create-message',
        'data': message,
      };

      webSocketService.sendMessage(wsMessage);
    });

    on<MessagesUpdated>((event, emit) {
      messages.clear();
      messages.addAll(event.updatedMessages);
      emit(ChatLoaded(messages: List.from(messages)));
    });

// Add NewMessageReceived event
    on<NewMessageReceived>((event, emit) {
      messages.insert(0, event.message);
      emit(
        ChatLoaded(
          messages: List.from(messages),
        ),
      );
    });
  }

  void _connectWebSocket(WebSocketService webSocketService) {
    webSocketService.messages.listen((message) {
      final decodedMessage = jsonDecode(message);

      if (decodedMessage['event'] == 'greeting') {
        if (roomId == null) {
          roomId = decodedMessage['data']['roomId'];
          log('Received roomId: $roomId');
          add(const GetRoomMessages());
        }
      }

      if (decodedMessage['event'] == 'find-messages') {
        final fetchedMessages =
            List<Map<String, dynamic>>.from(decodedMessage['data']);
        add(
          MessagesUpdated(
            fetchedMessages,
          ),
        );
      }

      if (decodedMessage['event'] == 'new-message' &&
          decodedMessage['data']['author'] == 'admin') {
        final newMessage = Map<String, dynamic>.from(decodedMessage['data']);
        add(
          NewMessageReceived(
            newMessage,
          ),
        );
      }

      log('Received message: ${decodedMessage['event']} for roomId: $roomId');
    });
  }
}
