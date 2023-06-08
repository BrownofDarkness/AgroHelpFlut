import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agrohelp/utils/dimentions.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';
import 'package:agrohelp/routes/route_helper.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
 const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var product = Get.find<PopularProductController>().popularProductList[pageId];
    // Get.snackbar() pour afficher un message sue l'écran genre une notif selon l'action du User
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background Image
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImageSize(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/funfood.jpeg",
                    ),
                  ),
                ),
          )),
          // icon widgets
          Positioned(
              top: Dimensions.height20(context) + Dimensions.height15(context),
              left: Dimensions.width20(context),
              right: Dimensions.width20(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios,)),
                  AppIcon(icon: Icons.shopping_cart_outlined,),
                ],
              )
          ),
          // introduction of food
          Positioned(
            left: 0,
              right: 0,
              top: Dimensions.popularFoodImageSize(context)-Dimensions.height20(context),
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context), top: Dimensions.height20(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20(context)),
                    topLeft: Radius.circular(Dimensions.radius20(context))
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text:"Better Orange beautiful"),
                    SizedBox(height: Dimensions.height20(context),),
                    BigText(text: "Introduise"),
                    SizedBox(height: Dimensions.height10(context),),
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",)))
                  ],
                ),
              )
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.height20(context)*6,
        padding: EdgeInsets.only(top: Dimensions.height30(context), bottom: Dimensions.height30(context), left: Dimensions.width20(context), right: Dimensions.width20(context)),
        decoration: BoxDecoration(
          color: Appcolors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20(context)*2),
              topLeft: Radius.circular(Dimensions.radius20(context)*2)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height10(context), bottom: Dimensions.height10(context), right: Dimensions.width20(context), left: Dimensions.width20(context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20(context)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: Appcolors.signColor,),
                  SizedBox(width: Dimensions.width10(context)/2,),
                  BigText(text: "0"),
                  SizedBox(width: Dimensions.width10(context)/2,),
                  Icon(Icons.add, color: Appcolors.signColor,),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Dimensions.height10(context), bottom: Dimensions.height10(context), right: Dimensions.width20(context), left: Dimensions.width20(context)),
              child: BigText(text: "\$10 | Add to cart",color: Colors.white,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20(context)),
                color: Appcolors.mainColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
