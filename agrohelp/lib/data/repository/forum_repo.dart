import 'package:agrohelp/model/forum_model.dart';
import 'package:agrohelp/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/signUp_model.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ForumRepo extends GetxService{

  final ApiClient apiClient;

  ForumRepo({required this.apiClient});

  Future<Response> createForum(Forum forum ) async {
    return await apiClient.postData("${AppConstants.FORUM_URI}forum/", forum.toJson());
  }

  Future<Response> getQuestions() async {
    return await apiClient.getData("${AppConstants.FORUM_URI}forum/");
  }
}