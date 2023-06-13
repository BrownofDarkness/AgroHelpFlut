import 'package:get/get.dart';
import 'package:agrohelp/data/api/api_client.dart';
import 'package:agrohelp/utils/app_constants.dart';
class CultureRepo extends GetxService{
  final ApiClient apiClient;

  CultureRepo({required this.apiClient});

  Future<Response> getRecommendedCulture() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_CULTURE_URI);
  }

  Future<Response> getSuggestCulture(int id) async {
    return await apiClient.getData("${AppConstants.PARCEL_URI}$id/suggest_culture/");
  }

  Future<Response> addParcel(Map parcel) async {
    return await apiClient.postData(AppConstants.PARCEL_URI, parcel);
  }

  Future<Response> getPopularCulture() async {
    return await apiClient.getData(AppConstants.POPULAR_CULTURE_URI);
  }

  Future<Response> getCulture(int id) async {
    return await apiClient.getData("${AppConstants.CULTURE_URI}$id/");
  }

  Future<Response> getCulturePractices(int id) async {
    return await apiClient.getData("${AppConstants.CULTURE_URI}$id/practise/");
  }

  Future<Response> getCultureFertlizers(int id) async {
    return await apiClient.getData("${AppConstants.CULTURE_URI}$id/fertilizers/");
  }

  Future<Response> getCultureDiseases(int id) async {
    return await apiClient.getData("${AppConstants.CULTURE_URI}$id/diseases/");
  }

  Future<Response> getFavorableAreas(int id) async {
    return await apiClient.getData("${AppConstants.CULTURE_URI}$id/favorable_areas/");
  }
}