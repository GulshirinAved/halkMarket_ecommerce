import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/auth_repository.dart';

part 'remove_accaunt_event.dart';
part 'remove_accaunt_state.dart';

class RemoveAccauntBloc extends Bloc<RemoveAccauntEvent, RemoveAccauntState> {
  RemoveAccauntBloc() : super(RemoveAccauntInitial()) {
    final AuthRepository removeAccauntRepository = AuthRepository();
    on<RemoveAccauntSubmitted>((event, emit) async {
      await removeAccauntRepository.removesAccaunt();
      emit(RemoveAccauntSuccess());
    });
  }
}
