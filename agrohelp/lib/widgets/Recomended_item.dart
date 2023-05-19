import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/text_cliper.dart';
import '../routes/route_helper.dart';
import '../utils/dimentions.dart';
import 'app_column.dart';

class RecommendedItem extends StatefulWidget {
  late bool isStared;
  final int id;
  RecommendedItem({Key? key, required this.isStared, required this.id}) : super(key: key);

  @override
  State<RecommendedItem> createState() => _RecommendedItemState();
}

class _RecommendedItemState extends State<RecommendedItem> {
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
              image: AssetImage(
                  "assets/images/sunfood.jpeg"
              ),
            ),
          ),
        ),

        //front shadow on image
        Positioned(
            child: GestureDetector(
              onTap: (){
                print("object");
                Get.toNamed(RouteHelper.getCropDetail(widget.id));
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
        // start icone
        Positioned(
          top: Dimensions.height10(context),
          right: Dimensions.width20(context)*3.5,
          child: GestureDetector(
              onTap: (){
                if (!widget.isStared){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Mon pop-up'),
                        content: Text('Contenu du pop-up'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel', style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),),
                            style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.red, // Couleur de fond du bouton
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                widget.isStared = true;
                                print(widget.isStared);
                              });
                            },
                            child: Text('add', style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ],
                      );
                    },
                  );
                }else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Mon pop-up'),
                        content: Text('Contenu du pop-up'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel', style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Couleur de fond du bouton
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                widget.isStared = false;
                                print(widget.isStared);
                              });
                            },
                            child: Text('remove', style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ],
                      );
                    },
                  );
                }

              },
              child:widget.isStared? Icon(Icons.star, color: Colors.yellowAccent,size: Dimensions.width30(context)*1.7,): Icon(Icons.star_border_purple500_outlined, color: Colors.white,size: Dimensions.width30(context)*1.8,)
          ),
        ),
        Positioned(
          top: Dimensions.height30(context)*5,
          left: Dimensions.width30(context)*1.5,
          child: Align(
            child: Container(
              width: Dimensions.width30(context)*20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clipper(Dimensions.width30(context).toInt(),"crop Name hjshdjsd jshdjsdsjgeytezzte qgdgdsfyds ",Dimensions.width30(context)*1.5),
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Chakra_Petch',
                      fontSize: Dimensions.height15(context)*1.2,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10(context),),
                  Text(
                    clipper((Dimensions.width30(context)*2).toInt(), "Cropskdhsjhdjshdjdsdjssjsdhjsdhjsdhsdjssdjsjsgdhgsgdhgsdgshdgshdgsg", Dimensions.width30(context)*2.3),
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Chakra_Petch',
                      fontSize: Dimensions.height15(context),
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
