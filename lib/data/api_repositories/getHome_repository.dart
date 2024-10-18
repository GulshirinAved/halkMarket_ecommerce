import 'package:halkmarket_ecommerce/data/api_providers/getHome_provider.dart';
import 'package:halkmarket_ecommerce/data/models/getHome_model.dart.dart';

class GetHomeRepository {
  final HomeProvider _getHomeProvider = HomeProvider();
  Future<List<dynamic>> fetchHomeBanner() async {
    return _getHomeProvider.fetchAllHomeBanner();
  }

  Future<List<dynamic>> fetchPopularCategory() async {
    return _getHomeProvider.fetchPopularCategory();
  }

  Future<List<dynamic>> fetchSmallCategory() async {
    return _getHomeProvider.fetchSmallCategory();
  }

  Future<List<List<Row>>> fetchAllHomeProducts() async {
    return _getHomeProvider.fetchAllHomeProducts();
  }

  Future<List<Datum>> fetchAllHomeData() async {
    return _getHomeProvider.fetchAllHomeData();
  }
}
