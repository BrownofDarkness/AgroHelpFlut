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
      update;
    }else{
      print(response.statusText.toString());
    }

  }

  Future<void> getPopularCultureList() async {
    Response response = await cultureRepo.getPopularCulture();
    if(response.statusCode == 200){
      print("get recommended cultures");
      _popularcultureList = [];
      response.body.forEach((item){
         _popularcultureList.add(Culture.fromJson(item));
      });
    }else{
      print(response.statusText.toString());
    }

    update;
  }

}
