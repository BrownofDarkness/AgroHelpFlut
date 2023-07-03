class AppConstants {
  static const String APP_NAME = "AgroHelp";
  static const String APP_VERSION = "1";

  static const String IP = "192.168.1.188";
  static const String BASE_URL = "https://agrohelp-6cl9.onrender.com";
  static const String WS_URL = "ws://agrohelp-6cl9.onrender.com";
  static const String BASE_URL2 = "http://$IP:8000";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String CULTURE_URI = "/api/core/culture/";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String RECOMMENDED_CULTURE_URI =
      "/api/core/culture/recommended/";
  static const String POPULAR_CULTURE_URI = "/api/core/culture/populars/";

  //auth endpoints
  static const String USER_URI = "/api/account/user/";
  static const String PARCEL_URI = "/api/core/parcel/";
  static const String SEARCH_URI = "/api/core/search/";
  static const String LOGIN_URI = "/api/account/auth/";
  static const String FORUM_URI = "/api/forum/";

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
}
