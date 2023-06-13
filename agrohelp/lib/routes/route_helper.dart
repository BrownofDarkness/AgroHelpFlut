import 'package:agrohelp/pages/food/popular_food.dart';
import 'package:agrohelp/pages/food/recommended_food_detail.dart';
import 'package:agrohelp/pages/forum/forum_details.dart';
import 'package:agrohelp/pages/home/forum_page.dart';
import 'package:agrohelp/pages/home/search_page.dart';
import 'package:get/get.dart';

import '../pages/account/account_page.dart';
import '../pages/auth/sign_in_page.dart';
import '../pages/auth/sing_up_page.dart';
import '../pages/crops/crop_detail_page.dart';
import '../pages/crops/soil_area_map.dart';
import '../pages/forum/forum_comment_replies.dart';
import '../pages/home/agro_home.dart';
import '../pages/home/favorite_crop_page.dart';
import '../pages/home/home_page.dart';
import '../pages/home/initial.dart';
import '../pages/home/map_testing.dart';
import '../pages/home/user_home.dart';
import '../pages/parcel/add_parcel_page.dart';
import '../pages/parcel/view_parcel.dart';
import '../pages/splash/splash_page.dart';
import '../pages/wheather/wheather_page.dart';
class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String welcome = "/welcome";
  static const String test = "/test";
  static const String area = "/area";
  static const String login = "/login";
  static const String parcelView = "/parcel-view";
  static const String profile = "/profile";
  static const String userHome = "/user-home";
  static const String searchpage = "/search-page";
  static const String favorites = "/favorite-crops";
  static const String favoritePage = "/favorite-page";
  static const String wheatherPage = "/wheather-page";
  static const String forumPage = "/forum-page";
  static const String register = "/register";
  static const String addParcel = "/add-parcel";
  static const String home = "/home";
  static const String forumDetails = "/forum-details";
  static const String forumCommentReplies = "/forum-comment-replies";
  static const String popularFood = "/popular-food";
  static const String cropDetail = "/crop-detail";
  static const String recommendedFood = "/recommended-food";

  static String getSplashPage() => "$splashPage";
  static String getWelcome() => "$welcome";
  static String getLogin() => "$login";
  static String getParcelView() => "$parcelView";
  static String getUserHome() => "$userHome";
  static String getSearchpage() => "$searchpage";
  static String getfavorites() => "$favorites";
  static String gettest() => "$test";
  static String getFavoritePage() => "$favoritePage";
  static String getWheatherPage() => "$wheatherPage";
  static String getforumPage() => "$forumPage";
  static String getProfile() => "$profile";
  static String getRegister() => "$register";
  static String getaddParcelPage() => "$addParcel";
  static String getHome(int id ) => "$home?parcel=$id";
  static String getArea(int id ) => "$area?soil=$id";
  static String getForumDetails(int index) => "$forumDetails?forum=$index";
  static String getForumCommentReplies(int forum, int comment) => "$forumCommentReplies?forum=$forum&&comment=$comment";
  static String getInitial() => "$initial";
  static String getPopularFood(int pageId) => "$popularFood?pageId=$pageId";
  static String getCropDetail(int id, String side, int index) => "$cropDetail?id=$id&&index=$index&&side=$side";
  static String getRecommendedFood(int id ) => "$recommendedFood?id=$id";

  static List <GetPage> routes= [
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: welcome, page: ()=>AgroHome()),
    GetPage(name: login, page: ()=>SingInPage(), transition: Transition.fadeIn),
    GetPage(name: test, page: ()=>MapTesting(), transition: Transition.fadeIn),
    GetPage(name: userHome, page: ()=>UserHomePage(), transition: Transition.fadeIn),
    GetPage(name: parcelView, page: ()=>ViewParcelList(), transition: Transition.fadeIn),
    GetPage(name: searchpage, page: ()=>SearchPage(), transition: Transition.fadeIn),
    GetPage(name: forumPage, page: ()=>ForumPage(), transition: Transition.fadeIn),
    GetPage(name: favoritePage, page: ()=>FavoriteCropsPage(), transition: Transition.fadeIn),
    GetPage(name: wheatherPage, page: ()=>WheatherPage(), transition: Transition.fadeIn),
    GetPage(name: profile, page: ()=>AccountPage(), transition: Transition.fadeIn),
    GetPage(name: register, page: ()=>SingUpPage(), transition: Transition.fadeIn),
    GetPage(name: initial, page: ()=>Initial()),
    GetPage(name: addParcel, page: ()=>AddParcelPage(), transition: Transition.fadeIn),
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
      var index = Get.parameters['index'];
      var side = Get.parameters['side'];
      var id = Get.parameters['id'];
      return CropDetailPage(index: int.parse(index!), side: side!.toString(),id: int.parse(id!),);
    }, transition: Transition.fadeIn),

    GetPage(name: home, page: () {
      var id = Get.parameters['parcel'];
      return HomePage(id: int.parse(id!));
    }, transition: Transition.fadeIn),

    GetPage(name: forumDetails, page: () {
      var forum = Get.parameters['forum'];
      return ForumDetailsPage(forum: int.parse(forum!));
    }, transition: Transition.fadeIn),

    GetPage(name: forumCommentReplies, page: () {
      var forum = Get.parameters['forum'];
      var comment = Get.parameters['comment'];
      return CommentReplies(forum: int.parse(forum!), comment: int.parse(comment!),);
    }, transition: Transition.fadeIn),

    GetPage(name: area, page: () {
      var id = Get.parameters['soil'];
      return SoilAreaMap(soil: int.parse(id!));
    }, transition: Transition.fadeIn),

  ];
}