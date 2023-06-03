
import 'package:agrohelp/utils/dimentions.dart';
import 'package:agrohelp/widgets/comment_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_icon.dart';

class ForumDetailsPage extends StatefulWidget {
  const ForumDetailsPage({super.key});

  @override
  State<ForumDetailsPage> createState() => _ForumDetailsPageState();
}

class _ForumDetailsPageState extends State<ForumDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: Dimensions.height20(context),),
            Row(
                children: [
                  IconButton(
                    onPressed:  (){
                        Get.back();
                    }, 
                    icon: Icon(Icons.arrow_back, size: Dimensions.height30(context)),
                  ),
                  Expanded(child: Container()),
                ],
            ),
            SizedBox(height: Dimensions.height10(context),),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: Dimensions.screenWidth(context),
                        height: Dimensions.screenHeight(context)*0.3,
                        color: Colors.amber,
                      ),
                      SizedBox(height: Dimensions.height15(context),),
                      for (int i=0; i<10; i++)...[
                        CommentItem(),
                      ],
                      
                      SizedBox(height: Dimensions.height15(context),),
                    ]
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}