import 'package:agrohelp/routes/route_helper.dart';
import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoilAreaItem extends StatefulWidget {
  final index;
  final Map soil;
  const SoilAreaItem({super.key, required this.soil, required this.index});

  @override
  State<SoilAreaItem> createState() => _SoilAreaItemState();
}

class _SoilAreaItemState extends State<SoilAreaItem> {
  @override
  void initState() {
    super.initState();
  }

  String tronk(text, textHeight) {
    String firstHalf;
    if (text.length > textHeight) {
      firstHalf = text.substring(0, textHeight.toInt() - 10) + " .....";
    } else {
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
              image: AssetImage("assets/images/areas.jpeg"),
            ),
          ),
        ),

        //front shadow on image
        Positioned(
          child: GestureDetector(
            onTap: () {
              print("object");
            },
            child: Container(
              height: Dimensions.pageViewContainer(context),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.radius30(context)),
                color: Color.fromRGBO(0, 70, 0, 0.4),
              ),
            ),
          ),
        ),

        Positioned(
          child: Align(
            child: Container(
              height: Dimensions.pageViewContainer(context),
              margin: EdgeInsets.only(
                  left: Dimensions.width20(context),
                  right: Dimensions.width20(context) * 1.5),
              padding: EdgeInsets.only(
                  top: Dimensions.width20(context) * 1.5,
                  bottom: Dimensions.width20(context) * 1.5,
                  left: Dimensions.width15(context) * 3,
                  right: Dimensions.width10(context) * 2),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.radius30(context)),
              ),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getArea(widget.index));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    tronk(widget.soil["name"],
                        Dimensions.pageViewContainer(context) * 0.7),
                    style: TextStyle(
                      fontFamily: 'Chakra_Petch',
                      fontSize: Dimensions.height15(context) * 1.2,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
