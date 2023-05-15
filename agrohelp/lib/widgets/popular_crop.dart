import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/text_cliper.dart';
import '../utils/dimentions.dart';

class PopularCrop extends StatefulWidget {
  late  bool isStared;
  PopularCrop({Key? key,required this.isStared}) : super(key: key);

  @override
  State<PopularCrop> createState() => _PopularCropState();
}

class _PopularCropState extends State<PopularCrop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height30(context)*8,
      width: Dimensions.width30(context)*13,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius30(context)),topRight: Radius.circular(Dimensions.radius30(context)),)
      ),
      child: Column(
        children: [
          //image conatiner
          GestureDetector(
            onTap: (){
              print("object");
            },
            child: Container(
              height: Dimensions.height30(context)*6,
              width: Dimensions.width30(context)*13,
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/sunfood.jpeg",
                      )
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius30(context)),topRight: Radius.circular(Dimensions.radius30(context)),)
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white60,
                border: Border.all(width: Dimensions.height10(context)/40, color: Colors.grey)

              ),
              child: Row(
                children: [
                  //name of the populars
                  Container(
                    height: Dimensions.height30(context)*2.5,
                    width: Dimensions.width30(context)*9,
                    padding: EdgeInsets.only(left: Dimensions.width20(context)),
                    decoration: BoxDecoration(

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.height10(context),),
                        Text(
                          clipper(10,"crop Name hjshdjsd jshdjsdsjgeytezzte qgdgdsfyds ",Dimensions.width30(context)*2),
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Chakra_Petch',
                            fontSize: Dimensions.height15(context),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: Dimensions.height10(context),),
                        Text(
                          clipper(15, "Cropskdhsjhdjshdjdsdjssjs dhjsdhjsdhsdjssdjsjsgdhgsgdhgsdgshdgshdgsg", Dimensions.width30(context)*0.1),
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Chakra_Petch',
                            fontSize: Dimensions.height15(context)*0.8,
                            overflow: TextOverflow.visible,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // star icon conatiner
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimensions.height30(context)*2.5,
                      decoration: BoxDecoration(
                      ),
                      child: GestureDetector(
                          onTap: (){
                            setState(() {
                              widget.isStared = !widget.isStared;
                              print(widget.isStared);
                            });
                          },
                          child:widget.isStared? Icon(Icons.star, color: Colors.redAccent,size: Dimensions.width30(context)*1.7,): Icon(Icons.star_border_purple500_outlined, color: Colors.grey,size: Dimensions.width30(context)*2,)
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
