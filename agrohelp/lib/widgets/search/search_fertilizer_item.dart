import 'package:flutter/material.dart';

import '../../utils/dimentions.dart';
import '../app_icon.dart';
import '../big_text.dart';
import '../small_text.dart';

class SearchFertilizerItem extends StatefulWidget {
  final Map fertilizer;
  const SearchFertilizerItem({super.key, required this.fertilizer});

  @override
  State<SearchFertilizerItem> createState() => _SearchFertilizerItemState();
}

class _SearchFertilizerItemState extends State<SearchFertilizerItem> {
  String tronk(text, textHeight) {
    String firstHalf;
    if (text.length > textHeight) {
      firstHalf = text.substring(0, textHeight.toInt()) + " ...";
    } else {
      firstHalf = text;
    }
    return firstHalf;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return FullScreenDialog(
                  content: Column(
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      height: Dimensions.height30(context) * 3,
                      child: Row(
                        children: [
                          Container(
                            width: Dimensions.screenWidth(context) -
                                Dimensions.width20(context) * 9,
                          ),
                          Container(
                              alignment: Alignment.center,
                              width: Dimensions.width20(context) * 9,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: AppIcon(
                                    icon: Icons.close,
                                    backgroundColor: Colors.transparent,
                                    iconsize: Dimensions.height30(context),
                                    size: Dimensions.height30(context),
                                  ))),
                        ],
                      )),
                  Container(
                    width: Dimensions.screenWidth(context),
                    height: Dimensions.pageViewContainer(context),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "${widget.fertilizer['image']}",
                          ),
                        )),
                  ),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: Dimensions.width20(context)),
                          height: Dimensions.screenHeight(context) * 0.6,
                          child: Container(
                              child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Dimensions.height20(context),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${widget.fertilizer["name"]}',
                                      style: TextStyle(
                                        fontFamily: 'Chakra_Petch',
                                        fontSize:
                                            Dimensions.height15(context) * 1.2,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20(context),
                                  ),
                                  Text(
                                    'Engrai de type ${widget.fertilizer["type"] == "chemical" ? "Chimique" : "Organique"}',
                                    style: TextStyle(
                                      fontFamily: 'Chakra_Petch',
                                      fontSize:
                                          Dimensions.height15(context) * 1.2,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10(context),
                                  ),
                                  Text(
                                    'Composition : \n\t\t\t${widget.fertilizer["composition"]}',
                                    style: TextStyle(
                                      fontFamily: 'Chakra_Petch',
                                      fontSize:
                                          Dimensions.height15(context) * 1.2,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10(context),
                                  ),
                                  Text(
                                    'Description : \n\t\t\t${widget.fertilizer["description"]}',
                                    style: TextStyle(
                                      fontFamily: 'Chakra_Petch',
                                      fontSize:
                                          Dimensions.height15(context) * 1.2,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10(context),
                                  ),
                                ]),
                          ))))
                ],
              ));
            });
      },
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width20(context),
            right: Dimensions.width20(context),
            bottom: Dimensions.height10(context)),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.radius20(context)),
                color: Color.fromARGB(255, 220, 238, 213),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${widget.fertilizer["image"]}"),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20(context)),
                    bottomRight: Radius.circular(Dimensions.radius20(context)),
                  ),
                  color: Color.fromARGB(255, 220, 238, 213),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.width10(context),
                      right: Dimensions.width10(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(
                        text: widget.fertilizer["name"],
                        size: Dimensions.font16(context),
                      ),
                      SizedBox(
                        height: Dimensions.height10(context),
                      ),
                      SmallText(
                        text: tronk(widget.fertilizer["description"],
                            Dimensions.height15(context)),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
