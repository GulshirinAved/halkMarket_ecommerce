import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final String url;
  final String token;
  late WebSocketChannel channel;

  WebSocketService(this.url, this.token) {
    channel = IOWebSocketChannel.connect(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Stream<dynamic> get messages => channel.stream;

  void sendMessage(Map<String, dynamic> message) {
    channel.sink.add(jsonEncode(message));
  }

  void dispose() {
    channel.sink.close();
  }
}
