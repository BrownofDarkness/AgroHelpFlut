import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../routes/route_helper.dart';
import '../../utils/dimentions.dart';
import 'package:get/get.dart';

class AgroHome extends StatefulWidget {
  const AgroHome({Key? key}) : super(key: key);

  @override
  State<AgroHome> createState() => _AgroHomeState();
}

class _AgroHomeState extends State<AgroHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: Dimensions.welcometopview(context),
            width: Dimensions.screenWidth(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/agri.jpg"
                ),

              ),
              color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(Dimensions.radius20(context)*7 + Dimensions.radius20(context)),
                )
            ),
            child: Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                Text(
                  "Welcome to the world  of agriculture",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.width30(context)*2,
                  ),
                ),
                  SizedBox(height: Dimensions.height10(context),),
                  Text(
                    "Here, we make your life easy",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: Dimensions.width20(context)*2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: Dimensions.welcomebottomview(context),
            width: Dimensions.screenWidth(context),
            padding: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  "With AgroHelp, improve your performance",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Roboto',
                    color: Color(0xFF025592),
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.width30(context)*1.5,
                  ),
                ),
                SizedBox(height: Dimensions.height30(context),),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.width30(context)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check, color: Color(0xFF02690C),size: Dimensions.height20(context)*1.6,),
                          SizedBox(width: Dimensions.width10(context),),
                          Text(
                            "Check the weather",
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.width20(context)*1.5,
                            ),
                          ),                      ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check, color: Color(0xFF02690C),size: Dimensions.height20(context)*1.6,),
                          SizedBox(width: Dimensions.width10(context),),
                          Text(
                            "Get informations about a culture",
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.width20(context)*1.5,
                            ),
                          ),                      ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check, color: Color(0xFF02690C),size: Dimensions.height20(context)*1.6,),
                          SizedBox(width: Dimensions.width10(context),),
                          Text(
                            "Discuss between farmers",
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.width20(context)*1.5,
                            ),
                          ),                      ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check, color: Color(0xFF02690C),size: Dimensions.height20(context)*1.6,),
                          SizedBox(width: Dimensions.width10(context),),
                          Text(
                            "Get informations about your parcel",
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.width20(context)*1.5,
                            ),
                          ),                      ],
                      ),
                      SizedBox(height: Dimensions.height20(context)*6,)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.width30(context),right: Dimensions.width30(context)),
                  child:  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getLogin());
                    },
                    child: Container(
                      width: Dimensions.width20(context)*15,
                      height: Dimensions.screenHeight(context)/17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                        color: Color(0xFF025592),
                      ),
                      child: Center(
                        child: Text(
                          "Suivant",
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: Dimensions.width20(context)*2,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
