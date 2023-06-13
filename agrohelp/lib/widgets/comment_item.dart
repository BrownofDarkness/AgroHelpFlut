import 'package:agrohelp/model/forum_model.dart';
import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatefulWidget {
  final Comments comment;
  CommentItem({super.key, required this.comment});

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: Dimensions.screenWidth(context),
      padding: EdgeInsets.only(right: Dimensions.width20(context), top: Dimensions.height15(context)),
      // color: Colors.redAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: Dimensions.width30(context),),
          Container(
            width: Dimensions.screenWidth(context)*0.90,
            decoration: BoxDecoration(
              // color: Colors.amber,
              borderRadius: BorderRadius.circular(Dimensions.radius20(context))
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: Dimensions.width15(context)*0.5),
                  height: Dimensions.height20(context)*2,
                  
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white,),
                      ),
                      SizedBox(width: Dimensions.width30(context)*0.55,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: Dimensions.width15(context), right: Dimensions.width15(context)),
                          height: Dimensions.height20(context)*2,
                          decoration: BoxDecoration(
                          color: Color.fromARGB(255, 44, 131, 231),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20(context)), topRight: Radius.circular(Dimensions.radius20(context))),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 44, 131, 231),
                              blurRadius: 6,
                              offset: Offset(1, 0), // décalage vers le bas et la droite

                            ),
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 5,
                              offset: Offset(0, 2), // décalage vers le haut et la gauche
                              spreadRadius: 0, // ne pas étendre l'ombre
                            ),
                          ],
                        ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                            widget.comment.author!.username!,
                            style: TextStyle(
                              fontFamily: 'Chakra_Petch',
                              fontSize: Dimensions.height15(context),
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.comment.author!.type!,
                            style: TextStyle(
                              fontFamily: 'Chakra_Petch',
                              fontSize: Dimensions.height15(context),
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Container(  
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.radius20(context)), bottomRight: Radius.circular(Dimensions.radius20(context))),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 44, 131, 231),
                          blurRadius: 6,
                          offset: Offset(1, 0), // décalage vers le bas et la droite

                        ),
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 5,
                          offset: Offset(0, 2), // décalage vers le haut et la gauche
                          spreadRadius: 0, // ne pas étendre l'ombre
                        ),
                      ],
                    ),
                    width: Dimensions.screenWidth(context)*0.75+Dimensions.width15(context)*0.5,
                    padding: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context), top: Dimensions.height10(context),bottom: Dimensions.height10(context)),
                    child: Text(
                      widget.comment.content!,
                      style: TextStyle(
                        fontFamily: 'Chakra_Petch',
                        color: Colors.black,
                        fontSize: Dimensions.font16(context)*0.85,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  ),
                )
              ]
            ),
          ),
        ]
      ),
    );
  }
}