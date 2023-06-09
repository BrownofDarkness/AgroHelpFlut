import 'package:get/get.dart';
import 'package:agrohelp/data/api/api_client.dart';
import 'package:agrohelp/utils/app_constants.dart';
class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductsList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}