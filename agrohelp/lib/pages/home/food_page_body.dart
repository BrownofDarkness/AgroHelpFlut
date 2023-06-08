import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agrohelp/data/controllers/popular_product_controller.dart';
import 'package:agrohelp/utils/colors.dart';
import 'package:agrohelp/utils/dimentions.dart';
import 'package:agrohelp/widgets/big_text.dart';
import 'package:agrohelp/widgets/small_text.dart';
import 'package:agrohelp/routes/route_helper.dart';

import '../../utils/app_constants.dart';
import '../../widgets/app_column.dart';
import '../../widgets/icon_text_widget.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPagevalue = 0.0;
  double _scaleFactor = 0.8;
  double _height(BuildContext context) =>
      Dimensions.pageViewContainer(context);
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPagevalue = pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts){
          //CircularProgressIndicator() pour le loading avec utilisation d'une condition isloaded
          return Container(
            height: Dimensions.Pageview(context),
            child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.isNotEmpty?popularProducts.popularProductList.length:5,
                itemBuilder: (context, position){
                  return _buildPageItem(position,popularProducts.popularProductList.isEmpty?null:popularProducts.popularProductList[position]);
                }
            ),
          );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isNotEmpty?popularProducts.popularProductList.length:5,
            position: _currPagevalue,
            decorator: DotsDecorator(
              activeColor: Appcolors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(height: Dimensions.height30(context),),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30(context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular" ),
              SizedBox(width: Dimensions.width10(context),),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10(context),),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairting",),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.height20(context),),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(index));
                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context),bottom: Dimensions.height10(context)),
                  child: Row(
                    children: [
                      Container(
                        width:120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20(context)),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/funfood.jpeg",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20(context)),
                              bottomRight: Radius.circular(Dimensions.radius20(context)),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10(context), right: Dimensions.width10(context)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: "Nutritious fruit in China, yes it is here"),
                                SizedBox(height: Dimensions.height10(context),),
                                SmallText(text: "With the chinese characteristics"),
                                SizedBox(height: Dimensions.height10(context),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(icon: Icons.circle_sharp,
                                      text: "Normal",
                                      iconColor: Appcolors.iconColor1,),
                                    IconAndTextWidget(icon: Icons.location_on,
                                      text: "1.7km",
                                      iconColor: Appcolors.mainColor,),
                                    IconAndTextWidget(icon: Icons.access_time_rounded,
                                      text: "32min",
                                      iconColor: Appcolors.iconColor2,)
                                  ],

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
  Widget _buildPageItem(int index, popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currPagevalue.floor()){
      var currScale = 1- (_currPagevalue-index)*(1-_scaleFactor);
      var currTrans = _height(context)*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if (index == _currPagevalue.floor()+1){
      var currScale = _scaleFactor+(_currPagevalue-index+1)*(1-_scaleFactor);
      var currTrans = _height(context)*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if (index == _currPagevalue.floor()-1){
      var currScale = 1-(_currPagevalue-index)*(1-_scaleFactor);
      var currTrans = _height(context)*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height(context), 0);
    }
    return Transform(
        transform: matrix,
        child: Stack(
          children: [
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getPopularFood(index));
              },
              child: Container(
                height: Dimensions.pageViewContainer(context),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                  color:index.isEven? Color(0xFF69c5df): Color(0xFF9294cc),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    // ici on devrait utiliser NetworkImage si elle vienne du serveur
                    image: AssetImage(
                        popularProduct==null?"assets/images/funfood.jpeg":"${AppConstants.BASE_URL}/media/${popularProduct.img!}"
                    ),
                  ),
                ),
          ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer(context),
              margin: EdgeInsets.only(left: Dimensions.width30(context), right: Dimensions.width30(context), bottom: Dimensions.height30(context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20(context)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5)

                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0)

                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(5,0)

                  )
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15(context),left: Dimensions.width15(context),right: Dimensions.width15(context)),
                child: AppColumn(text: "Better Orange beautiful",),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
