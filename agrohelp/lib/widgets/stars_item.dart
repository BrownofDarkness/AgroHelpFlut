import 'package:agrohelp/data/controllers/culture_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/show_custom_snackBar.dart';
import '../routes/route_helper.dart';
import '../utils/dimentions.dart';
import 'app_icon.dart';

class StarsItem extends StatefulWidget {
  late bool fav;
  final bool rec;
  final int cult;
  final bool detail;
  StarsItem({super.key, required this.rec, required this.fav, required this.cult, required this.detail});

  @override
  State<StarsItem> createState() => _StarsItemState();
}

class _StarsItemState extends State<StarsItem> {

  void _addCultureToParcel(CultureController cultureController){
    cultureController.addCultureToParcel(widget.cult).then((status){
      if(status.isSucess==true){
        ShowCustomSnackBar("culture was succesfully added on your active parcel", title: "Add culture", isError: false);
      }else{
        ShowCustomSnackBar(status.message,);
        print(status.message);
      }
    });
  }

  void _removeCultureToParcel(CultureController cultureController){
    cultureController.removeCultureToParcel(widget.cult).then((status){
      if(status.isSucess==true){
        ShowCustomSnackBar("culture was succesfully removed from your active parcel", title: "remove culture", isError: false);
      }else{
        ShowCustomSnackBar(status.message,);
        print(status.message);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<CultureController>(builder: (CultureController){
      return GestureDetector(
          onTap: (){
            print(widget.fav);
            if (!widget.fav){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add an Culture'),
                    content: Text('you see this dialog because you want to add a culture on your active parcel'),
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
                            _addCultureToParcel(CultureController);
                            print(widget.fav);
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
              if (widget.rec) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Remove an culture'),
                      content: Text('you see this dialog because you want to remove this culture on your active parcel'),
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
                              _removeCultureToParcel(CultureController);
                              print(widget.fav);
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
              
            }

          },
          child:widget.detail?(widget.fav&&widget.rec?AppIcon(icon: Icons.playlist_remove_rounded,iconColor: Color.fromARGB(255, 88, 9, 6),):AppIcon(icon: Icons.add_reaction_outlined)):(widget.fav? Icon(Icons.star, color: widget.rec?Colors.yellowAccent:Colors.redAccent,size: Dimensions.width30(context)*1.7,): Icon(Icons.star_border_purple500_outlined, color: widget.rec?Colors.white:Colors.grey,size: Dimensions.width30(context)*1.8,))
      );
    });
  }
}