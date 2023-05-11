import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class Dimensions{
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double Pageview(BuildContext context) =>
      screenHeight(context)/2.6;
  static double welcometopview(BuildContext context) =>
      screenHeight(context)*0.45;
  static double welcomebottomview(BuildContext context) =>
      screenHeight(context)*0.55;
  //static double pageViewContainer= screenHeight/3.84;
  static double pageViewContainer(BuildContext context) =>
      screenHeight(context)/3.84;
  //static double pageViewTextContainer= screenHeight/7.03;

  //dynamic heights
  //static double height10= screenHeight/84.4;
  static double height10(BuildContext context) =>
      screenHeight(context)/84.4;
  //static double height15= screenHeight/56.52;
  static double height15(BuildContext context) =>
      screenHeight(context)/56.52;
  //static double height20= screenHeight/42.2;
  static double height20(BuildContext context) =>
      screenHeight(context)/42.2;
  //static double height30= screenHeight/28.13;
  static double height30(BuildContext context) =>
      screenHeight(context)/28.13;

  // dynamic width
  //static double width10= screenWidth/84.4;
  static double width10(BuildContext context) =>
      screenWidth(context)/84.4;
  //static double width15= screenWidth/56.52;
  static double width15(BuildContext context) =>
      screenWidth(context)/56.52;
  //static double width20= screenWidth/42.2;
  static double width20(BuildContext context) =>
      screenWidth(context)/42.2;
  //static double width30= screenWidth/28.13;
  static double width30(BuildContext context) =>
      screenWidth(context)/28.13;

  //icon sizes
  //static double iconSize24= screenHeight/35.17;
  static double iconSize24(BuildContext context) =>
      screenHeight(context)/35.17;
  //static double iconSize16= screenHeight/52.75;
  static double iconSize16(BuildContext context) =>
      screenHeight(context)/52.75;

  //fontsize
  //static double font16= screenHeight/52.75;
  static double font16(BuildContext context) =>
      screenHeight(context)/52.75;
  //static double font20= screenHeight/42.2;
  static double font20(BuildContext context) =>
      screenHeight(context)/42.2;
  //static double font26= screenHeight/32.46;
  static double font26(BuildContext context) =>
      screenHeight(context)/32.46;

  //static double radius20= screenHeight/42.2;
  static double radius20(BuildContext context) =>
      screenHeight(context)/42.2;
  //static double radius30= screenHeight/28.13;
  static double radius30(BuildContext context) =>
      screenHeight(context)/28.13;

  //popular food
  //static double popularFoodImageSize= screenHeight/2.41;
  static double popularFoodImageSize(BuildContext context) =>
      screenHeight(context)/2.41;

  static pageViewTextContainer(BuildContext context) {}

}