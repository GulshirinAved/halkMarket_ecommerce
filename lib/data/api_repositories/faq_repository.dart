import 'package:halkmarket_ecommerce/data/api_providers/faq_provider.dart';
import 'package:halkmarket_ecommerce/data/models/faq_model.dart';

class FaqRepository {
  final FaqProvider faqProvider = FaqProvider();
  Future<List<Row>> getFaq() async {
    return faqProvider.getFaq();
  }
}
