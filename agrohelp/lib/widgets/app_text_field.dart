import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/dimentions.dart';


class AppTextField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final bool isObscur;
  String content;
  AppTextField({Key? key, required this.textController, required this.hintText, required this.icon, this.isObscur=false,required this.content}) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20(context)*2, right: Dimensions.height20(context)*2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF02690C),
              blurRadius: 6,
              offset: Offset(0, 3), // décalage vers le bas et la droite

            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 5,
              offset: Offset(-2, -2), // décalage vers le haut et la gauche
              spreadRadius: 0, // ne pas étendre l'ombre
            ),
          ]
      ),
      child: TextField(
        onChanged: (value){
          widget.content = value;
        },
        textInputAction: TextInputAction.next,
        onEditingComplete: () {

          // Réaffectez la valeur saisie au champ de texte
          setState(() {
            widget.textController.text = widget.content;
          });
        },
        onSubmitted: (value){
          setState(() {
            print(widget.textController.text);
            widget.textController.text = widget.content;
          });
        },
        obscureText: widget.isObscur?true:false,
        controller: widget.textController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(widget.icon, color: Colors.black,),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius20(context))*0.5,
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.white,
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )
          ),
        ),
      ),
    );
  }
}
