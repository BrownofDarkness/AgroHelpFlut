import 'package:flutter/cupertino.dart';
import 'package:agrohelp/utils/dimentions.dart';
class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({Key? key, this.color= const Color(0xFF332d2b),
    required this.text,
    this.size=0,
    this.overflow = TextOverflow.ellipsis
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: 'Chakra_Petch',
        fontWeight: FontWeight.w700,
        color: color,
        fontSize: size==0?Dimensions.font20(context):size,
      ),
    );
  }
}
