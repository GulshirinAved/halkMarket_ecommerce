import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/getOneCataloge_repository.dart';
import 'package:halkmarket_ecommerce/data/models/getOneCatalog_model.dart';

part 'get_one_cateloge_event.dart';
part 'get_one_cateloge_state.dart';

class GetOneCatelogeBloc
    extends Bloc<GetOneCatelogeEvent, GetOneCatelogeState> {
  GetOneCatelogeBloc() : super(GetOneCatelogeInitial()) {
    final GetOneCatalogeRepository getOneCatalogeRepository =
        GetOneCatalogeRepository();

    on<GetOneCataloge>((event, emit) async {
      try {
        final getOneCatalogeList =
            await getOneCatalogeRepository.getOneCataloge(event.id);
        emit(GetOneCatalogeLoaded(getOneCatalogeList: getOneCatalogeList));
      } catch (e) {
        emit(GetOneCatalogeError(error: e.toString()));
      }
    });
  }
}
