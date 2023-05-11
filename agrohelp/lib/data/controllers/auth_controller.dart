import 'package:get/get.dart';

import '../../model/response_model.dart';
import '../../model/signUp_model.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isloading = false;
  bool get isloading => _isloading;

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

    if(response.statusCode == 200){
      authRepo.saveToken(response.body["Token"]);
      responseModel = ResponseModel(true, response.body["Token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isloading = true;
    update();
    return responseModel;
  }

  saveNumberAndPassword(String number , String password) async {
    authRepo.saveNumberAndPassword(number, password);
  }


  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
}