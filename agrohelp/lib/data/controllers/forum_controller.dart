import 'package:agrohelp/data/repository/forum_repo.dart';
import 'package:agrohelp/model/forum_model.dart';
import 'package:agrohelp/model/response_model.dart';
import 'package:get/get.dart';


class ForumController extends GetxController implements GetxService{
  final ForumRepo forumRepo;

  ForumController({required this.forumRepo});

  bool _isloading = false;
  bool get isloading => _isloading;

  List<dynamic> _forums = [];
  List<dynamic> get forums => _forums;

  Future<ResponseModel> createForum(Forum forum) async {
    _isloading = true;
    Response response = await forumRepo.createForum(forum);
    late ResponseModel responseModel;

    if(response.statusCode == 200){
      responseModel = ResponseModel(true, response.body['content']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
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
}