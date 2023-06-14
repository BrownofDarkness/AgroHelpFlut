import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/cultures_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimentions.dart';
import '../big_text.dart';
import '../small_text.dart';

class SearchCultureItem extends StatefulWidget {
  final int index;
  final Culture culture; 
  const SearchCultureItem({super.key, required this.culture, required this.index});

  @override
  State<SearchCultureItem> createState() => _SearchCultureItemState();
}

class _SearchCultureItemState extends State<SearchCultureItem> {

  String tronk(text, textHeight){
    String firstHalf;
    if(text.length > textHeight){
        firstHalf = text.substring(0, textHeight.toInt())+" ...";
      }else{
        firstHalf = text;
      }
      return firstHalf;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getSearchCropDetail(widget.culture.id!, widget.index));
      },
      child: Container(
        margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context),bottom: Dimensions.height10(context)),
        child: Row(
          children: [
            Container(
              width:120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20(context)),
                color: Color.fromARGB(255, 220, 238, 213),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "${AppConstants.BASE_URL}${widget.culture.photo}"
                  ),
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
                  padding: EdgeInsets.only(left: Dimensions.width10(context), right: Dimensions.width10(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(text: widget.culture.name!, size: Dimensions.font16(context),),
                      SizedBox(height: Dimensions.height10(context),),
                      SmallText(text: tronk(widget.culture.description!, Dimensions.height15(context)), color: Colors.grey,),
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