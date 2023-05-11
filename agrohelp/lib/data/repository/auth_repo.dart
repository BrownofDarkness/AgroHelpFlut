import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/signUp_model.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class AuthRepo extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SingUpModel singUpModel ) async {
    return await apiClient.postData(AppConstants.USER_URI, singUpModel.toJson());
  }

  Future<Response> login(String email , String password) async {

    return await apiClient.postData(AppConstants.LOGIN_URI, {"email":email, "password":password});
  }

  Future<Response> hello() async {
    return await apiClient.getData(AppConstants.PARCEL_URI);
  }

  Future<bool> saveToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  Future<void> saveNumberAndPassword(String number , String password) async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }
  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    return true;
  }
}