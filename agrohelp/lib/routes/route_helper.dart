import 'package:agrohelp/pages/food/popular_food.dart';
import 'package:agrohelp/pages/food/recommended_food_detail.dart';
import 'package:agrohelp/pages/home/main_food_page.dart';
import 'package:get/get.dart';

import '../pages/account/account_page.dart';
import '../pages/auth/sign_in_page.dart';
import '../pages/auth/sing_up_page.dart';
import '../pages/crops/crop_detail_page.dart';
import '../pages/home/agro_home.dart';
import '../pages/home/home_page.dart';
import '../pages/home/initial.dart';
import '../pages/home/user_home.dart';
import '../pages/parcel/add_parcel_page.dart';
import '../pages/splash/splash_page.dart';
class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String profile = "/profile";
  static const String register = "/register";
  static const String addParcel = "/add-parcel";
  static const String userHome = "/user-home";
  static const String popularFood = "/popular-food";
  static const String cropDetail = "/crop-detail";
  static const String recommendedFood = "/recommended-food";

  static String getSplashPage() => "$splashPage";
  static String getWelcome() => "$welcome";
  static String getLogin() => "$login";
  static String getProfile() => "$profile";
  static String getRegister() => "$register";
  static String getaddParcelPage() => "$addParcel";
  static String getUserHome() => "$userHome";
  static String getInitial() => "$initial";
  static String getPopularFood(int pageId) => "$popularFood?pageId=$pageId";
  static String getCropDetail(int id, String side) => "$cropDetail?id=$id&&side=$side";
  static String getRecommendedFood(int id ) => "$recommendedFood?id=$id";

  static List <GetPage> routes= [
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: welcome, page: ()=>AgroHome()),
    GetPage(name: login, page: ()=>SingInPage(), transition: Transition.fadeIn),
    GetPage(name: profile, page: ()=>AccountPage(), transition: Transition.fadeIn),
    GetPage(name: register, page: ()=>SingUpPage(), transition: Transition.fadeIn),
    GetPage(name: initial, page: ()=>Initial()),
    GetPage(name: addParcel, page: ()=>AddParcelPage(), transition: Transition.fadeIn),
    GetPage(name: userHome, page: ()=>UserHomePage()),
    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      return PopularFoodDetail(pageId: int.parse(pageId!),);
    },
        transition: Transition.fadeIn),
    GetPage(name: recommendedFood, page: () {
      var id = Get.parameters['id'];
      return RecommendedFoodDetail(id: int.parse(id!),);
    }, transition: Transition.fadeIn),
    GetPage(name: cropDetail, page: () {
      var id = Get.parameters['id'];
      var side = Get.parameters['side'];
      return CropDetailPage(id: int.parse(id!), side: side!.toString(),);
    }, transition: Transition.fadeIn),

  ];
}