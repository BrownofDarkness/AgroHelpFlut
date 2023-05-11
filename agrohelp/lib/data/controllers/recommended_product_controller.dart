import 'package:agrohelp/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';

import '../../model/produsts_model.dart';
import '../repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recomendedProductList => _recommendedProductList;
  RecommendedProductController({required this.recommendedProductRepo}) {
    // TODO: implement RecommendedProductRepo
    throw UnimplementedError();
  }

  Future<void> getRecommendedProductsList() async {
    Response response = await recommendedProductRepo.getRecommendedProductsList();
    if(response.statusCode == 200){
      print("get products");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      print(_recommendedProductList);
      update;
    }else{
      print(response.statusText.toString());
    }
  }
}
