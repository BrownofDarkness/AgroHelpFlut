import 'package:agrohelp/model/response_model.dart';
import 'package:get/get.dart';

import '../../model/cultures_model.dart';
import '../repository/culture_repo.dart';

class CultureController extends GetxController{
  final CultureRepo cultureRepo;

  List<Map> _recommendedcultureList = [];
  List<Map> get recommendedcultureList => _recommendedcultureList;

  List<Map> _suggestedcultureList = [];
  List<Map> get suggestedcultureList => _suggestedcultureList;

  List<dynamic> _popularcultureList = [];
  List<dynamic> get popularcultureList => _popularcultureList;
  bool _recload = false;
  bool get isrecload => _recload;

  bool _popload = false;
  bool get ispopload => _popload;

  dynamic _parcel;
  dynamic get parcel => _parcel;

  dynamic _culture;
  dynamic get culture => _culture;

  Map _cultureDetails = {
    "practises":[],
    "fertilizers":[],
  };
  Map get cultureDetails => _cultureDetails;
  

  CultureController({required this.cultureRepo});
  
  Future<void> getRecommendedList() async {
    _recload = true;
    Response response = await cultureRepo.getRecommendedCulture();
    if(response.statusCode == 200){
      print("get recommended cultures");
      _recommendedcultureList = [];

      response.body.forEach((item){
        Map recom = {
        "culture": Culture.fromJson(item["culture"]),
        "favorite": item["favorite"],
        };
        _recommendedcultureList.add(recom);
      });
      _recload = false;
      update();
    }else{
      print(response.statusText.toString());
    }

  }

  Future<void> getSuggestList(int id) async {
    _recload = true;
    Response response = await cultureRepo.getSuggestCulture(id);
    if(response.statusCode == 200){
      print("get recommended cultures");
      _suggestedcultureList = [];

      response.body.forEach((item){
        Map recom = {
        "culture": Culture.fromJson(item),
        "favorite": false,
        };
        _suggestedcultureList.add(recom);
      });
      _recload = false;
      update();
    }else{
      print(response.statusText.toString());
    }

  }

  Future<void> getPopularCultureList() async {
    _popload = true;
    Response response = await cultureRepo.getPopularCulture();
    if(response.statusCode == 200){
      print("get popular cultures");
      _popularcultureList = [];
      response.body.forEach((item){
        Map pop = {
        "culture": Culture.fromJson(item["culture"]),
        "favorite": item["favorite"],
        };
        _popularcultureList.add(pop);
      });
      _popload = false;
      update();
    }else{
      print(response.statusText.toString());
    }

  }

  Future<void> getCulture(int id) async {
    Response response =  await cultureRepo.getCulture(id);
    _culture = Culture.fromJson(response.body);
    update();
  }

  Future<void> getCulturedetails(int id) async {
    _cultureDetails["practises"] = [];
    _cultureDetails["fertilizers"] = [];
    _cultureDetails["diseases"] = [];
    _cultureDetails["soils"] = [];
    Response response =  await cultureRepo.getCulturePractices(id);
    Response response2  = await cultureRepo.getCultureFertlizers(id);
    Response response3  = await cultureRepo.getCultureDiseases(id);
    Response response4  = await cultureRepo.getFavorableAreas(id);
    print(response4.body["features"][0]['geometry']['coordinates'][0][0][1]);
    response.body.forEach((item){
        Map pract = {
        "name": item["name"],
        "practise": item["practise"],
        };
        _cultureDetails["practises"].add(pract);
    });
    print(_cultureDetails["practises"][0]);

    response2.body.forEach((item){
        Map fert = {
        "name": item["name"],
        "composition": item["composition"],
        "type": item["type"],
        "description": item["description"],
        };
        _cultureDetails["fertilizers"].add(fert);
    });

    response3.body.forEach((item){
        Map dis = {
        "image": item["image"],
        "disease_name": item["disease_name"],
        "solution": item["solution"],
        "description": item["description"],
        };
        _cultureDetails["diseases"].add(dis);
    });

    response4.body["features"].forEach((item){
      Map soil = {
        "name": item['properties']['soil']["type"],
        "area": item['geometry']['coordinates'][0],
        };
      _cultureDetails["soils"].add(soil);
    });
    update();
  }

  void setparcel(id){
    _parcel = id;
    update();
  }

  Future<ResponseModel> addParcel(Map parcel) async {
    Response response = await cultureRepo.addParcel(parcel);
    late ResponseModel responseModel;

    if(response.statusCode == 201){
      print(response.body["data"]['location']);
      responseModel = ResponseModel(true, response.body["data"]['name']);

    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

}
