import 'package:agrohelp/data/repository/forum_repo.dart';
import 'package:agrohelp/model/forum_model.dart';
import 'package:agrohelp/model/response_model.dart';
import 'package:get/get.dart';

import 'dart:convert';


class ForumController extends GetxController implements GetxService{
  final ForumRepo forumRepo;

  ForumController({required this.forumRepo});

  bool _isloading = false;
  bool get isloading => _isloading;

  List<dynamic> _forums = [];
  List<dynamic> get forums => _forums;

  Future<ResponseModel> createForum(String content) async {
    _isloading = true;
    Response response = await forumRepo.createForum(content);
    late ResponseModel responseModel;

    if(response.statusCode == 201){
      responseModel = ResponseModel(true, response.body['content']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }

  Future<dynamic> createForumComment(Comments comment) async {
    Response response = await forumRepo.createForumComent(comment);
    late ResponseModel responseModel;

    if(response.statusCode == 201){
      print("ok");
      responseModel = ResponseModel(true, response.body['content']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getQuestions() async {
    _forums = [];
    Response response =  await forumRepo.getQuestions();
    response.body.forEach((item){
      _forums.add(Forum.fromJson(item));   
    });
    print(_forums[0].author.username);
    update();
  }

  void addNewForum(forum){
    print('voici ${forum}');
    if (check(forum,_forums)) {
      _forums.insert(0,Forum.fromJson(forum));
      update();
    }
    update();
  }

  void addNewForumComment(comment){
    print('voici ${comment}');
    Comments nouveau = Comments.fromJson(comment);
    _forums.forEach((item){
      if (nouveau.parent == null){
        if (item.id == nouveau.forum){
          if (check(comment,item.comments)) {
              print("object");
              item.comments.insert(0,nouveau);
              update();
          }
        }
      }else{
        Replies nouveau2 = Replies.fromJson(comment);
        item.comments.forEach((item2){
          if (item2.id == nouveau2.parent){
            if (check(comment,item2.replies)) {
                print("object");
                item2.replies.insert(0,nouveau2);
                update();
            }
          }
        });
      }   
    });
    update();
  }

  bool check(Map item, List<dynamic> list){
    bool add = true;
    for(int i=0;i < list.length;i++ ){
      if (list[i].id == item['id']){
        add = false;
        break;
      }
    }
    return add;
  }

  int getForumId(int index){
    return _forums[index].id;
  }
}