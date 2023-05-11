import 'package:get/get.dart';

import '../../model/produsts_model.dart';
import '../repository/popular_product_repo.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  PopularProductController({required this.popularProductRepo});

  Future<void> getPopularProductsList() async {
    Response response = await popularProductRepo.getPopularProductsList();
    if(response.statusCode == 200){
      print("get products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      update;
    }else{
      print(response.statusText.toString());
    }
  }
}