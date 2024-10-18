import 'package:halkmarket_ecommerce/data/api_providers/userAddress_provider.dart';
import 'package:halkmarket_ecommerce/data/models/adress_model.dart';

class UserAddressRepository {
  final UserAdressProvider userAdressProvider = UserAdressProvider();
  Future<Data> addAddress({
    required String id,
    required String address,
    required String apartment,
    required String entrance,
    required String floor,
    required String comment,
    required String latitude,
    required String longitude,
  }) async {
    return userAdressProvider.addAdress(
      id: id,
      address: address,
      apartment: apartment,
      entrance: entrance,
      floor: floor,
      comment: comment,
      latitude: latitude,
      longitude: longitude,
    );
  }

  Future<Data> removeAddress({required String id}) async {
    return userAdressProvider.removeAddress(id: id);
  }
}
