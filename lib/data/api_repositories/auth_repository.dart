import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/models/updateUserData_model.dart';

class AuthRepository {
  final AuthProvider _authProvider = AuthProvider();
  Future<int?> signUp({
    String? phone,
    String? name,
    String? address,
    String? birthday,
    String? email,
    String? gender,
    String? password,
  }) async {
    return _authProvider.register(
      phone: phone,
      name: name,
      address: address,
      birthday: birthday,
      email: email,
      gender: gender,
      password: password,
    );
  }

  Future<int?> otp({String? phone, int? otp}) async {
    return _authProvider.otp(phone: phone, otp: otp);
  }

  Future<int?> signIn({String? phone, String? password}) async {
    return _authProvider.signIn(phone: phone, password: password);
  }

  Future<int?> forgetPass({String? phone, String? password}) async {
    return _authProvider.forgetPass(phone: phone, password: password);
  }

  Future<Data> updateUserData({
    required String? name,
    required String? email,
    required String? phone,
    required String? birthday,
    required String? gender,
  }) async {
    return _authProvider.updateUserData(
      name: name,
      email: email,
      phone: phone,
      birthday: birthday,
      gender: gender,
    );
  }

  Future<int?> removesAccaunt() async {
    return _authProvider.removeAccount();
  }

  Future<Data> getUserProfile() async {
    return _authProvider.getUserProfile();
  }

  Future<Data?> changePass(
      {required String newPass, required String oldPass}) async {
    return _authProvider.changePass(newPass: newPass, oldPass: oldPass);
  }
}
