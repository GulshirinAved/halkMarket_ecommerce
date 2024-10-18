import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/getOneProduct_repository.dart';
import 'package:halkmarket_ecommerce/data/models/getOneProduct_model.dart';

part 'get_one_product_event.dart';
part 'get_one_product_state.dart';

class GetOneProductBloc extends Bloc<GetOneProductEvent, GetOneProductState> {
  GetOneProductBloc() : super(GetOneProductInitial()) {
    final GetOneProductRepository getOneProductRepository =
        GetOneProductRepository();
    on<GetOneProduct>((event, emit) async {
      try {
        final Data getOneProduct =
            await getOneProductRepository.getOneProductRepository(event.id);
        emit(GetOneProductLoaded(getOneProductList: getOneProduct));
      } catch (e) {
        emit(GetOneProductError(error: e.toString()));
      }
    });
  }
}
