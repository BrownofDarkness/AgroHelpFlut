import 'package:agrohelp/pages/drawer/Drawer_page.dart';
import 'package:agrohelp/utils/dimentions.dart';
import 'package:agrohelp/widgets/forum_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../data/controllers/culture_controller.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  var question = TextEditingController();
 

  String tronk(text, textHeight){
    String firstHalf;
    if(text.length > textHeight){
        firstHalf = text.substring(0, textHeight.toInt())+" .....";
      }else{
        firstHalf = text;
      }
      return firstHalf;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    question.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF025592),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white54,size: Dimensions.height30(context),),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Ouvre le drawer
              },
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text("Forum Page",
                  style: TextStyle(
                    fontFamily: 'Chakra_Petch',
                    color: Colors.white60,
                    fontSize: Dimensions.height20(context),
                  ),
                  overflow: TextOverflow.visible,
                ),

              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: Dimensions.width30(context)*3,
              child: Icon(Icons.notifications, color: Colors.white54,size: Dimensions.height30(context),),
            ),
          ],
        ),
      ),
      drawer: DrawerPage(),
      body: Container(
        padding: EdgeInsets.only(left: Dimensions.width20(context)*1.5, right: Dimensions.width20(context)*1.5, top: Dimensions.height20(context)),
        child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                height: Dimensions.height30(context)*2,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                      child: TextField(
                        cursorColor: Color(0xFF025592),
                        style: TextStyle(
                          fontFamily: 'Chakra_Petch',
                          fontSize: Dimensions.height15(context),
                          fontWeight: FontWeight.w600
                        ),
                        decoration:   InputDecoration(
                          hintText: "Ask a Question",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius20(context))*0.5,
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.grey,
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.3),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.5),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            )
                          ),
                        ),
                        controller: question,
                      )
                    )
                    ),
                    SizedBox(width:Dimensions.width10(context)),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          print("lancer la rechrche");
                        },
                        child: Text('Submit', style: TextStyle(
                          fontFamily: 'Chakra_Petch',
                          color: Colors.white,
                          fontSize: Dimensions.font16(context),
                          fontWeight: FontWeight.bold,
                        ),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, 
                          minimumSize: Size(Dimensions.width20(context)*0.7, Dimensions.height30(context)*1.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height30(context),),
              GetBuilder<CultureController>(builder: (cultures){
                return Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 30,
                    itemBuilder: (context, index){
                      return ForumItem();
                  }),
                )
              );
              }),
              
            ],
          ),
      )
    );
  }
}