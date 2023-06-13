
import 'package:agrohelp/widgets/app_icon.dart';
import 'package:flutter/material.dart';

import '../utils/app_constants.dart';
import '../utils/dimentions.dart';

class IllnessViewItem extends StatefulWidget {

  final index;
  final Map illness;
  const IllnessViewItem({super.key, required this.illness, required this.index});

  @override
  State<IllnessViewItem> createState() => _IllnessViewItemState();
}

class _IllnessViewItemState extends State<IllnessViewItem> {

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
    return Stack(
      children: [
        //background image
        Container(
          height: Dimensions.pageViewContainer(context),
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
            color: Color(0xFF9294cc),
            image: DecorationImage(
              fit: BoxFit.cover,
              // ici on devrait utiliser NetworkImage si elle vienne du serveur
              image: NetworkImage(
               "${AppConstants.BASE_URL}${widget.illness['image']}",
              ),
            ),
          ),
        ),

        //front shadow on image
        Positioned(
            child: GestureDetector(
              onTap: (){
                print("object");
               
              },
              child: Container(
                height: Dimensions.pageViewContainer(context),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                  color: Color.fromRGBO(0, 70, 0, 0.4),
                ),
              ),
            ),
        ),
        
        Positioned(
          child: Align(
            child: Container(
              height: Dimensions.pageViewContainer(context),
              margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)*1.5),
              padding: EdgeInsets.only(top: Dimensions.width20(context)*1.5, bottom: Dimensions.width20(context)*1.5,left: Dimensions.width15(context)*3, right: Dimensions.width10(context)*2),
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                
              ),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                        context: context,
                    
                        builder: (BuildContext context) {
                          return FullScreenDialog(
                            
                            content: Column(children: [
                              Container(
                                alignment: Alignment.topCenter,
                                height: Dimensions.height30(context)*3,
                                child: Row(children: [
                                Container(
                                  width: Dimensions.screenWidth(context)-Dimensions.width20(context)*9,
                                ),
                                
                                Container(
                                  alignment: Alignment.center,
                                  width: Dimensions.width20(context)*9,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: AppIcon(icon: Icons.close,backgroundColor: Colors.transparent,iconsize: Dimensions.height30(context), size: Dimensions.height30(context),)
                                  )
                                ),
                                ],
                                )
                              ),
                              Container(
                                width: Dimensions.screenWidth(context),
                                height: Dimensions.pageViewContainer(context),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "${AppConstants.BASE_URL}${widget.illness['image']}"
                                    ),
                                  )
                                ),
                              ),
                              SizedBox(height: Dimensions.height15(context),),
                              Expanded(
                                child: Container(
                                padding: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)),
                                width: Dimensions.screenWidth(context),
                                child: Container(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${widget.illness["disease_name"]}',
                                            style: TextStyle(
                                              fontFamily: 'Chakra_Petch',
                                              fontSize: Dimensions.height15(context)*1.2,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        
                                        SizedBox(height: Dimensions.height10(context),),
                                        Text(
                                          'Description : \n\t\t\t${widget.illness["description"]}',
                                          style: TextStyle(
                                            fontFamily: 'Chakra_Petch',
                                            fontSize: Dimensions.height15(context)*1.2,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.height10(context),),
                                        Text(
                                          'Solutions : \n\t\t\t${widget.illness["solution"]}',
                                          style: TextStyle(
                                            fontFamily: 'Chakra_Petch',
                                            fontSize: Dimensions.height15(context)*1.2,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.height10(context),),
                                    ]),
                                                          )
                                                            )
                                                      )
                              )
                            ],)
                          );
                        }
                        );
                },
                child: Text(
                          tronk(
                            '${widget.illness["disease_name"]} |  \n\n${widget.illness["description"]}',
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
            ),
          ),
        ),
      ],
    );
  }
}

class FullScreenDialog extends Dialog {
  final Widget content;

  FullScreenDialog({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(225, 202, 201, 201),
      constraints: BoxConstraints.expand(),
      child: content,
    );
}
}

