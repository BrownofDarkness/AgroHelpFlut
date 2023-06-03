import 'dart:async';

import 'package:agrohelp/model/cultures_model.dart';
import 'package:agrohelp/widgets/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/controllers/culture_controller.dart';
import '../helper/text_cliper.dart';
import '../routes/route_helper.dart';
import '../utils/dimentions.dart';
import 'app_column.dart';

class ViewItem extends StatefulWidget {
  final index;
  final Map fertlizer;
  ViewItem({Key? key, required this.fertlizer, required this.index}) : super(key: key);

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {

  String tronk(text, textHeight){
    String firstHalf;
    if(text.length > textHeight){
        firstHalf = text.substring(0, textHeight.toInt()-10)+" .....";
      }else{
        firstHalf = text;
      }
      return firstHalf;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
          height: Dimensions.pageViewContainer(context),
          margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)*1.5),
          padding: EdgeInsets.only(top: Dimensions.width20(context)*1.5, bottom: Dimensions.width20(context)*1.5,left: Dimensions.width15(context)*3, right: Dimensions.width10(context)*2),
          width: Dimensions.pageViewContainer(context)*0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
            color: Color.fromARGB(255, 51, 53, 133),
          ),
          child: GestureDetector(
            onTap: () {
              showDialog(
                    context: context,
                
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(children: [
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: AppIcon(icon: Icons.close,backgroundColor: Colors.transparent,iconsize: Dimensions.height30(context), size: Dimensions.height30(context),)
                          ),
                        ]),
                        content: Container(
                          padding: EdgeInsets.only(top: Dimensions.height20(context), left: Dimensions.width20(context)),
                          height: Dimensions.screenHeight(context)*0.6,
                          width: Dimensions.screenWidth(context),
                          color: Color.fromARGB(225, 202, 201, 201),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '${widget.fertlizer["name"]}',
                                  style: TextStyle(
                                    fontFamily: 'Chakra_Petch',
                                    fontSize: Dimensions.height15(context)*1.2,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.height20(context),),
                              Text(
                                'Engrai de type ${widget.fertlizer["type"]=="chemical"?"Chimique":"Organique"}',
                                style: TextStyle(
                                  fontFamily: 'Chakra_Petch',
                                  fontSize: Dimensions.height15(context)*1.2,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: Dimensions.height10(context),),
                              Text(
                                'Composition : \n\t\t\t${widget.fertlizer["composition"]}',
                                style: TextStyle(
                                  fontFamily: 'Chakra_Petch',
                                  fontSize: Dimensions.height15(context)*1.2,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: Dimensions.height10(context),),
                              Text(
                                'Description : \n\t\t\t${widget.fertlizer["description"]}',
                                style: TextStyle(
                                  fontFamily: 'Chakra_Petch',
                                  fontSize: Dimensions.height15(context)*1.2,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: Dimensions.height10(context),),
                          ]),
                        ),
                      );
                    }
                    );
            },
            child: Text(
                      tronk(
                        '${widget.fertlizer["name"]} | \n\nEngrais de type ${widget.fertlizer["type"]=="chemical"?"chimique":"organique"} | \n\n${widget.fertlizer["composition"]}',
                        Dimensions.pageViewContainer(context)*0.7
                      ),
                      style: TextStyle(
                        fontFamily: 'Chakra_Petch',
                        fontSize: Dimensions.height15(context)*1.2,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
          ),
        );
  }
}