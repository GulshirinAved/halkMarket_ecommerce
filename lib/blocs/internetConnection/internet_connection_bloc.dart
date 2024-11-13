import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'internet_connection_event.dart';
part 'internet_connection_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  InternetConnectionBloc()
      : super(
          InternetConnectionInitial(),
        ) {
    on<InternetListenEvent>((event, emit) async {
      try {
        final result = await InternetAddress.lookup('216.250.13.221');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          emit(const InternetConnectedState());
        }
      } on SocketException catch (_) {
        emit(const InternetNotConnectedState());
      }
    });
  }
}
