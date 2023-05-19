import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agrohelp/utils/dimentions.dart';

import 'package:agrohelp/widgets/small_text.dart';
import '../utils/colors.dart';

class ExpandableTextWidget extends StatefulWidget {
  final text;
  const ExpandableTextWidget({Key? key, this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight(BuildContext context) =>
      (Dimensions.screenHeight(context)/5.63).toDouble();

  @override
  void initState(){
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0, textHeight(context).toInt());
      secondHalf = widget.text.substring(textHeight(context).toInt()+1, widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(height: 1.8,color: Appcolors.paraColor,size: Dimensions.font16(context),text: firstHalf,):Column(
        children: [
          SmallText(height: 1.8,color: Appcolors.paraColor,size: Dimensions.font16(context),text: hiddenText?("$firstHalf..."):(firstHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: "Show more", color: Appcolors.mainColor,) ,
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: Appcolors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
