import 'package:get/get.dart';

import '../../model/response_model.dart';
import '../../model/signUp_model.dart';
import '../../model/user_model.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isloading = false;
  bool get isloading => _isloading;

  bool _isconnected = false;
  bool get isconnected => _isconnected;

  dynamic _user;
  dynamic get user => _user;

  Future<ResponseModel> registration(SingUpModel signUpModel) async {
    _isloading = true;
    Response response = await authRepo.registration(signUpModel);
    late ResponseModel responseModel;

    if(response.statusCode == 200){
      authRepo.saveToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = false;
    update();
    return responseModel;
  }
  Future<void> hello() async {
    Response response = await authRepo.hello();
    update();
    print(" hello: ${response.body}");
  }

  Future<ResponseModel> login(String email , String password) async {
    _isloading = true;
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    print("1: ${response.statusCode}");
    if(response.statusCode == 200){
      print(response.body["token"]);
      print(_isconnected);
      authRepo.saveToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
      _isconnected = true;
    }else{
      responseModel = ResponseModel(false, response.statusText!);
      print(response.body);
    }

    _isloading = false;
    update();
    return responseModel;
  }

  saveNumberAndPassword(String number , String password) async {
    authRepo.saveNumberAndPassword(number, password);
  }

Future<void> getUserToken() async {
    String val = await authRepo.getUserToken();
  }

  bool clearSharedData(){
    _isconnected = false;
    update();
    return authRepo.clearSharedData();
  }

Future <void> getUser() async{
  Response response = await authRepo.me();
  print(response.body[0]);
  _user = User.fromJson(response.body[0]);
  update();
}
}

