import 'package:agrohelp/model/forum_model.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ForumRepo extends GetxService{

  final ApiClient apiClient;

  ForumRepo({required this.apiClient});

  Future<Response> createForum(String content ) async {
    return await apiClient.postData("${AppConstants.FORUM_URI}forum/", {"content":content});
  }

  Future<Response> getQuestions() async {
    return await apiClient.getData("${AppConstants.FORUM_URI}forum/");
  }

  Future<Response> createForumComent(Comments comment ) async {
    return await apiClient.postData("${AppConstants.FORUM_URI}forum-comment/", comment.toJson());
  }
}