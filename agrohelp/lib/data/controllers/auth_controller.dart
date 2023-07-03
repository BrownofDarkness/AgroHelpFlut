import 'package:get/get.dart';

import '../../model/response_model.dart';
import '../../model/signUp_model.dart';
import '../../model/user_model.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isloading = false;
  bool get isloading => _isloading;

  bool _isconnected = false;
  bool get isconnected => _isconnected;

  dynamic _user;
  dynamic get user => _user;

  dynamic _userToken;
  dynamic get userToken => _userToken;

  dynamic _parcel;
  dynamic get parcel => _parcel;

  List<Map> _parcelList = [];
  List<Map> get parcelList => _parcelList;

  Map _wheather = {};
  Map get wheather => _wheather;

  Future<ResponseModel> registration(SingUpModel signUpModel) async {
    _isloading = true;
    Response response = await authRepo.registration(signUpModel);
    late ResponseModel responseModel;

    if (response.statusCode == 201) {
      authRepo.saveToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
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

  Future<ResponseModel> login(String email, String password) async {
    _isloading = true;
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    print("1: ${response.statusCode}");
    if (response.statusCode == 200) {
      print(response.body);
      print(_isconnected);
      authRepo.saveToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
      _isconnected = true;
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      print(response.body);
    }

    _isloading = false;
    update();
    return responseModel;
  }

  saveNumberAndPassword(String number, String password) async {
    authRepo.saveNumberAndPassword(number, password);
  }

  Future<void> getUserToken() async {
    String val = await authRepo.getUserToken();
    print(val);
    if (val != "None") {
      _userToken = val;
      _isconnected = true;
    }
    update();
  }

  bool clearSharedData() {
    _isconnected = false;
    update();
    return authRepo.clearSharedData();
  }

  Future<void> getUser() async {
    Response response = await authRepo.me();
    print(response.body[0]);
    _user = User.fromJson(response.body[0]);
    update();
  }

  void setparcel(id) {
    _parcel = id;
    update();
  }

  Future<void> getUserParcels() async {
    _parcelList = [];
    Response response = await authRepo.getUserParcels();
    response.body.forEach((item) {
      Map parcel = {
        "id": item["id"],
        "name": item["name"],
        "area": item["area"],
        "location": item["location"]["coordinates"],
      };
      if (check(parcel, _parcelList)) {
        _parcelList.add(parcel);
      }
    });
    print(_parcelList);
    update();
  }

  bool check(Map parcel, List<Map> list) {
    bool add = true;
    for (int i = 0; i < list.length; i++) {
      if (list[i]["id"] == parcel['id']) {
        add = false;
        break;
      }
    }
    return add;
  }

  Map searchParcel() {
    Map parcel = {};
    for (int i = 0; i < _parcelList.length; i++) {
      if (_parcelList[i]["id"] == _parcel) {
        parcel = _parcelList[i];
        break;
      }
    }
    return parcel;
  }

  void setwheather(List<Map> list) {
    _wheather['parcel'] = _parcel;
    _wheather['data'] = list;
    print(_wheather);
    update();
  }
}
