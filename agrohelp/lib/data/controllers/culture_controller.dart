import 'package:get/get.dart';

import '../../model/cultures_model.dart';
import '../repository/culture_repo.dart';

class CultureController extends GetxController{
  final CultureRepo cultureRepo;

  List<Map> _recommendedcultureList = [];
  List<Map> get recommendedcultureList => _recommendedcultureList;

  List<dynamic> _popularcultureList = [];
  List<dynamic> get popularcultureList => _popularcultureList;
  bool _recload = false;
  bool get isrecload => _recload;

  bool _popload = false;
  bool get ispopload => _popload;

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
    Response response =  await cultureRepo.getCulturePractices(id);
    Response response2  = await cultureRepo.getCultureFertlizers(id);
    _cultureDetails["practises"] = [];
    _cultureDetails["fertilizers"] = [];
    print(response.body[0]);
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
    update();
  }

}
