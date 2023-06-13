import 'package:agrohelp/widgets/stars_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/controllers/culture_controller.dart';
import '../helper/text_cliper.dart';
import '../routes/route_helper.dart';
import '../utils/dimentions.dart';

class PopularCrop extends StatefulWidget {
  final int index;
  final Map culture;
  PopularCrop({Key? key, required this.culture, required this.index}) : super(key: key);

  @override
  State<PopularCrop> createState() => _PopularCropState();
}

class _PopularCropState extends State<PopularCrop> {

  Future<void> _loadressource(int id ) async {
    await Get.find<CultureController>().getCulturedetails(id);
  }
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
              Get.toNamed(RouteHelper.getCropDetail(widget.culture["culture"].id,"p",widget.index));
            },
            child: Container(
              height: Dimensions.height30(context)*6,
              width: Dimensions.width30(context)*13,
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                      widget.culture["culture"].photo,
                    ),
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
                          clipper(10,widget.culture["culture"].name,Dimensions.width30(context)*2),
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Chakra_Petch',
                            fontSize: Dimensions.height15(context),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: Dimensions.height10(context)*0.5,),
                        Text(
                          clipper(15, widget.culture["culture"].description, Dimensions.width30(context)*0.1),
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
                      child: StarsItem(fav: widget.culture["favorite"],rec: false,cult: widget.culture["culture"].id,),
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
