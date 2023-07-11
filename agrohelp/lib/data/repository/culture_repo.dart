import 'package:get/get.dart';
import 'package:agrohelp/data/api/api_client.dart';
import 'package:agrohelp/utils/app_constants.dart';

class CultureRepo extends GetxService {
  final ApiClient apiClient;

  CultureRepo({required this.apiClient});

  Future<Response> getRecommendedCulture() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_CULTURE_URI);
  }

  Future<Response> getSuggestCulture(int id) async {
    return await apiClient
        .getData("${AppConstants.PARCEL_URI}$id/suggest_culture/");
  }

  Future<Response> search(String filter, String content) async {
    String filt = "";
    print(filter);
    if (filter == "culture") {
      filt = "culture";
    }
    if (filter == "maladie") {
      filt = "disease";
    }
    if (filter == "fertlisant") {
      filt = "fertilizer";
    }
    print("${AppConstants.SEARCH_URI}?${filt}=$content");
    return await apiClient.getData("${AppConstants.SEARCH_URI}?$filt=$content");
  }

  Future<Response> addParcel(Map parcel) async {
    return await apiClient.postData(AppConstants.PARCEL_URI, parcel);
  }

  Future<Response> addCultureToParcel(int parcel, int culture) async {
    return await apiClient
        .postData("${AppConstants.PARCEL_URI}$parcel/add_cultures/", {
      "ids": [culture]
    });
  }

  Future<Response> removeCultureToParcel(int parcel, int culture) async {
    return await apiClient
        .postData("${AppConstants.PARCEL_URI}$parcel/remove_cultures/", {
      "ids": [culture]
    });
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
    return await apiClient
        .getData("${AppConstants.CULTURE_URI}$id/fertilizers/");
  }

  Future<Response> getCultureDiseases(int id) async {
    return await apiClient.getData("${AppConstants.CULTURE_URI}$id/diseases/");
  }

  Future<Response> getFavorableAreas(int id) async {
    return await apiClient
        .getData("${AppConstants.CULTURE_URI}$id/favorable_areas/");
  }
}
