import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/faq_repository.dart';
import 'package:halkmarket_ecommerce/data/models/faq_model.dart';

part 'get_faq_event.dart';
part 'get_faq_state.dart';

class GetFaqBloc extends Bloc<GetFaqEvent, GetFaqState> {
  final FaqRepository _faqRepository = FaqRepository();
  GetFaqBloc() : super(GetFaqInitial()) {
    on<GetFaqList>((event, emit) async {
      try {
        final List<Row> faqList = await _faqRepository.getFaq();
        emit(GetFaqLoaded(faqList: faqList));
      } catch (e) {
        emit(GetFaqError(error: e.toString()));
      }
    });
  }
}
