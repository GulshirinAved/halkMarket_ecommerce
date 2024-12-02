import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'track_order_event.dart';
part 'track_order_state.dart';

class TrackOrderBloc extends Bloc<TrackOrderEvent, TrackOrderState> {
  late final IO.Socket _socket;

  TrackOrderBloc() : super(TrackOrderInitial()) {
    _initializeSocket();
    _socket.on(
      'new_locations',
      (data) {
        log('connected new location $data');

        add(TrackOrderNewLocationEvent(data: data));
      },
    );

    on<TrackOrderNewLocationEvent>(
      (event, emit) {
        emit(TrackOrderNewLocationState(data: event.data));
      },
    );
  }

  void _initializeSocket() {
    _socket = IO.io(Endpoints().socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {
        HttpHeaders.authorizationHeader: '${AuthProvider().getAccessToken()}',
      },
    });
  }

  Future<void> socketclose() {
    _socket.dispose();
    return super.close();
  }
}
