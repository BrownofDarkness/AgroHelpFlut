import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/controllers/culture_controller.dart';
import '../../helper/text_cliper.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/Recomended_item.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_text_widget.dart';
import '../../widgets/popular_crop.dart';
import '../../widgets/small_text.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPagevalue = 0.0;
  late bool start = false;
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
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //hello
            Container(
              padding: EdgeInsets.only(left: Dimensions.width20(context)),
                child: Text(
                    "Hello",
                    style: TextStyle(
                        fontSize: Dimensions.height30(context)*1.2,
                        fontFamily: 'Chakra_Petch',
                        fontWeight: FontWeight.w500
                    ),
                ),
            ),
            //welcome .....
            Container(
              padding: EdgeInsets.only(left: Dimensions.width20(context),top: Dimensions.width20(context)*0.2),
              child: Text(
                "welcome on your Home",
                style: TextStyle(
                    fontSize: Dimensions.height20(context),
                    fontFamily: 'Chakra_Petch',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),
              ),
            ),
            //space between, you can replace with a SizedBox
            Text(""),
            // what.... and see more
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: Dimensions.width20(context)),
                    alignment: Alignment.centerLeft,
                    height: Dimensions.height30(context),
                    child: Text(
                      "What are you looking for?",
                      style: TextStyle(
                          fontFamily: 'Chakra_Petch',
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
                Container(
                  width: Dimensions.width30(context)*10,
                  padding: EdgeInsets.only(right: Dimensions.width20(context)),
                  alignment: Alignment.centerRight,
                  height: Dimensions.height30(context),
                  child: GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: Dimensions.height30(context)*3,
                      height: Dimensions.height30(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20(context)),
                        color: Color(0xFF025592),
                      ),
                      child: Text(
                        "see more",
                        style: TextStyle(
                            fontSize: Dimensions.height15(context),
                            fontFamily: 'Chakra_Petch',
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: Dimensions.height10(context),),
            //Page view for recommended crops
            GetBuilder<CultureController>(builder: (cultures){
              return cultures.isrecload?Center(
                child: CircularProgressIndicator()
              ) : Container(
              height: Dimensions.Pageview(context)*0.75,
              child: PageView.builder(
                controller: pageController,
                itemCount: cultures.recommendedcultureList.length,
                itemBuilder: (context, position){
                return _buildPageItem(position,cultures.recommendedcultureList[position]);
                }
              ),
              );
            }),
            Container(
              padding: EdgeInsets.only(left: Dimensions.width20(context),top: Dimensions.width20(context)*0.2),
              child: Text(
                "Popular Crops",
                style: TextStyle(
                    fontSize: Dimensions.height20(context),
                    fontFamily: 'Chakra_Petch',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10(context),),
            Expanded(

              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: Dimensions.width20(context)),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.height10(context),),
                      for (int i = 0; i < 5; i += 2)...[
                        Row(
                          children: [
                            PopularCrop(isStared: false, id: i),
                            if (i+1 < 5)...[
                              SizedBox(width: Dimensions.width20(context)*1.2,),
                              PopularCrop(isStared: false, id: i+1),
                            ]
                          ],
                        ),
                        SizedBox(height: Dimensions.height10(context),)
                      ]
                    ],
                  ),
                ),
              )
            )
            // listView for most cultivated crops
            /*Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
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
              ),
            ),*/
          ],
        ),
      ),
    );
  }
  Widget _buildPageItem(int index ,culture) {
    Matrix4 matrix = Matrix4.identity();
    double currScale, currTrans;

    if (index == _currPagevalue.floor()) {
      currScale = 1 - (_currPagevalue - index) * (1 - _scaleFactor);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else if (index == _currPagevalue.floor() + 1) {
      currScale = _scaleFactor + (_currPagevalue - index + 1) * (1 - _scaleFactor);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else if (index == _currPagevalue.floor() - 1) {
      currScale = 1 - (_currPagevalue - index) * (1 - _scaleFactor);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else {
      currScale = 0.8;
      currTrans = _height(context) * (1 - currScale) / 2;
    }

    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix.setTranslationRaw(0, currTrans, 0);

    return Transform(
      transform: matrix,
      child: RecommendedItem(culture: culture, index: index,),
    );
  }
}
