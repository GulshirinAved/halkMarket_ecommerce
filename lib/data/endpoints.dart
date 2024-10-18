class Endpoints {
  final String url = 'http://216.250.13.221:8091/magaz';
  final String webSocketUrl = 'ws://216.250.13.221:8088';
  String get home => '$url/api/home';
  String category({required int page}) =>
      '$url/category/?page=$page&pageSize=10';
  String get allCategory => '$url/category/';
  String get allProducts => '$url/products/all';
  String oneCategory({required String? id}) => '$url/category/$id';
  String allBrands({required int? page}) =>
      '$url/category/brands?pageSize=10&page=$page';
  String get signUp => '$url/users/auth/sign-up';
  String get otp => '$url/users/auth/check-otp';
  String get signIn => '$url/users/auth/sign-in';
  String get forgetPass => '$url/users/auth/forgot-password';
  String get updateUserData => '$url/users/auth/update';
  String get removeAccaunt => '$url/users/auth/remove';
  String getOneProduct({required String? id}) => '$url/products/$id';
  String get createOrder => '$url/orders/create';
  String emailSubscribe({final String? email}) =>
      '$url/email-subscription?email=$email';
  String get paymentType => '$url/payments/payment-types';
  String get deliverType => '$url/payments/delivery-types';
  String refreshToken({required String? refresh}) => '$url/users/auth/refresh';
  String get userProfile => '$url/users/auth/profile';
  String get createFeedback => '$url/api/feedback-create';
  String get addBasket => '$url/orders/basket';
  String removeBasket({required String? id}) => '$url/orders/basket-remove/$id';
  String get removeAllBasket => '$url/orders/basket-remove-all';
  String get getFaq => '$url/api/faq-all';
  String get getQuestions => '$url/questions/questions';
  String voteAnswer({required String? id}) => '$url/questions/answer-vote/$id';
  String get orderHistory => '$url/orders/history';
  String oneOrderHistory({required String id}) => '$url/orders/history/$id';
  String get upsertUserAddress => '$url/users/address-upsert';
  String removeUserAddress({required String id}) =>
      '$url/users/address-remove/$id';
  String get changePass => '$url/users/auth/change-password';
  String cancelOrder({required String id}) => '$url/orders/cancel/$id';
}
