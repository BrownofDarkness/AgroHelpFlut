import 'package:agrohelp/data/repository/culture_repo.dart';
import 'package:get/get.dart';
import 'package:agrohelp/data/api/api_client.dart';
import 'package:agrohelp/data/repository/popular_product_repo.dart';
import 'package:agrohelp/data/repository/recommended_product_repo.dart';
import 'package:agrohelp/data/controllers/popular_product_controller.dart';
import 'package:agrohelp/data/controllers/recommended_product_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/controllers/auth_controller.dart';
import '../data/controllers/culture_controller.dart';
import '../data/controllers/forum_controller.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/forum_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api_clients
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //repositories
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(()=>CultureRepo(apiClient: Get.find()));
  Get.lazyPut(()=>ForumRepo(apiClient: Get.find()));
  Get.lazyPut(()=>PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=>RecommendedProductRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(()=>AuthController(authRepo: Get.find()));
  Get.lazyPut(()=>CultureController(cultureRepo: Get.find()));
  Get.lazyPut(()=>ForumController(forumRepo: Get.find()));
  Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo: Get.find()));

}