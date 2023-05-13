import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../widgets/Recomended_item.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF025592),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.menu_rounded, color: Colors.white54,),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text("welcome name",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: Dimensions.height20(context),
                ),
                    overflow: TextOverflow.visible,
                ),

              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.notifications, color: Colors.white54,),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //hello
            Container(
              padding: EdgeInsets.only(left: Dimensions.width20(context),top: Dimensions.width20(context)*1.5),
                child: Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: Dimensions.height30(context)*1.2,
                      fontFamily: 'Roboto',
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
                    fontFamily: 'Roboto',
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
                    child: Text("What are you looking for?"),
                  ),
                ),
                Expanded(
                  child: Container(
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
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.height10(context),),
            //Page view for recommended crops
            Container(
              height: Dimensions.Pageview(context),
              child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                itemBuilder: (context, position){
                return _buildPageItem(position);
                }
              ),
              ),
            // listView for most cultivated crops
            Container()
          ],
        ),
      ),
    );
  }
  Widget _buildPageItem(int index){
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
      child: RecommendedItem(isStared: false,),
    );

  }
}
