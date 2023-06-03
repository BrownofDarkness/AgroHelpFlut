import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';

import '../../data/controllers/auth_controller.dart';
import '../../data/controllers/culture_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimentions.dart';

class ViewParcelList extends StatefulWidget {
  const ViewParcelList({super.key});

  @override
  State<ViewParcelList> createState() => _ViewParcelListState();
}

class _ViewParcelListState extends State<ViewParcelList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authcontroller){
        return Column(
          children: [
            SizedBox(height: Dimensions.height30(context)*1.5,),
            Container(
              alignment: Alignment.topCenter,
              width: double.maxFinite,
              height: Dimensions.screenHeight(context)*0.2,
              child: Text(
                "Choose Parcel",
                style: TextStyle(
                  fontFamily: 'Chakra_Petch',
                  fontSize: Dimensions.height30(context),
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF025592),
                ),
              ),
            ),
            Expanded(

              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: Dimensions.width20(context)),
                  child: GetBuilder<CultureController>(builder: (cultures){
                    return Column(
                    children: [
                      SizedBox(height: Dimensions.height10(context),),
                      for (int i = 0; i < 5; i += 2)...[
                        Row(
                        children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getUserHome());
                            print("object1");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimensions.pageViewContainer(context),
                            margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)*1.5),
                            padding: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)),
                            width: Dimensions.pageViewContainer(context)*0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                              color: Color.fromARGB(255, 51, 53, 133),
                            ),
                            child: Text(
                              "Parcel $i",
                              style: TextStyle(
                                fontFamily: 'Chakra_Petch',
                                fontSize: Dimensions.height20(context),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),

                          )
                        ),
                        if (i+1 < 5)...[
                          SizedBox(width: Dimensions.height10(context),),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getUserHome());
                              print("object2");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: Dimensions.pageViewContainer(context),
                              margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)*1.5),
                              padding: EdgeInsets.only(top: Dimensions.width20(context)*1.5, bottom: Dimensions.width20(context)*1.5,left: Dimensions.width15(context)*3, right: Dimensions.width10(context)*2),
                              width: Dimensions.pageViewContainer(context)*0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                                color: Color.fromARGB(255, 51, 53, 133),
                              ),
                              child: Text(
                              "Parcel ${i+1}",
                              style: TextStyle(
                                fontFamily: 'Chakra_Petch',
                                fontSize: Dimensions.height20(context),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            )
                          ),
                        ] 
                      ],
                      ),
                      SizedBox(height: Dimensions.height10(context),)
                      ]
                      
                      
                    ],
                  );
                  }),
                ),
              )
            ),
            Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              height: Dimensions.screenHeight(context)*0.15,
              child: ElevatedButton(
                onPressed: () {
                  print("go on add Parcel ");
                  Get.toNamed(RouteHelper.getaddParcelPage());
                },
                child: Text('Add a parcel', style: TextStyle(
                  fontFamily: 'Chakra_Petch',
                  color: Colors.white,
                  fontSize: Dimensions.height20(context)*1.5,
                  fontWeight: FontWeight.bold,
                ),),
                
              ),
            ),
          ],
        );
      }),
    );
  }
}