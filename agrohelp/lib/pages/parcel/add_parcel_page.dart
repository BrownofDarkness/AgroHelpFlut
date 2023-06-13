import 'dart:async';

import 'package:agrohelp/data/controllers/culture_controller.dart';
import 'package:agrohelp/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../base/show_custom_snackBar.dart';
import '../../utils/dimentions.dart';
import '../../widgets/big_text.dart';

class AddParcelPage extends StatefulWidget {
  const AddParcelPage({Key? key}) : super(key: key);

  @override
  State<AddParcelPage> createState() => _AddParcelPageState();
}

class _AddParcelPageState extends State<AddParcelPage> {
  var nameController = TextEditingController();
  var sizeController = TextEditingController();
  var namefocus = FocusNode();
  var sizefocus = FocusNode();
  late LatLng _currentPosition = LatLng(0,0);
  
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition initialCameraPosition = const  CameraPosition( target: LatLng(7.369722, 12.354722), zoom: 8.0, );

  final List<Marker> _markers = <Marker>[
     Marker(
      markerId: MarkerId("1"),
      position: LatLng(7.369722, 12.354722),
      infoWindow: InfoWindow(
        title: "initial camera position.."
      ),
      
    )
  ];

  Future<Position> getUserCurrentLocation() async{

    await Geolocator.requestPermission().then((value) => {

    });

    return await Geolocator.getCurrentPosition();
  }  

  loadPosition(){
    getUserCurrentLocation().then((value) async{
      print("my current location");
      print(value.latitude.toString()+" "+ value.longitude.toString());
      _currentPosition = LatLng(value.latitude,value.longitude);
      _markers.add(
        Marker(
          markerId: MarkerId("2"),
          position: LatLng(value.latitude,value.longitude),
          infoWindow: InfoWindow(
            title: "my curent location"
          )
        )
      );
      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude,value.longitude
      ));

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {
        
      });
    });
  }

   @override
    void initState() {
      super.initState();
      loadPosition();
    }

  @override
  Widget build(BuildContext context) {

    void _addParcel(CultureController cultureController){
      String name = nameController.text.trim();
      int size = int.parse(sizeController.text.trim());
      if(name.isEmpty){
        ShowCustomSnackBar("type in an parcel name adress", title: "Parcel Name");
      }else if(size.isNaN) {
        ShowCustomSnackBar("type in your parcel size", title: "Parcel size");
      }else if(_currentPosition == LatLng(0,0)) {
        ShowCustomSnackBar("wait for géolocasation", title: "parcel location");
      }else{
        Map parcel = {
          "name": name,
          "area": size,
          "location": "srid=4326;POINT(${_currentPosition.longitude} ${_currentPosition.latitude})"
        };
        cultureController.addParcel(parcel).then((status){
          if(status.isSucess==true){
            ShowCustomSnackBar("parcel was succesfully added", title: "Add parcel", isError: false);
            Get.toNamed(RouteHelper.getParcelView());
          }else{
            ShowCustomSnackBar(status.message,);
            print(status.message);
          }
        });
        
      }
    }

    List<FocusNode> focusNodes = [
      namefocus,
      sizefocus,
    ];



    List<String> hintTexts = [
      "parcel name",
      "parcel size",
    ];

    List<IconData> icons = [
      Icons.text_fields,
      Icons.photo_size_select_large,

    ];

    List<TextInputType> types = [
      TextInputType.text,
      TextInputType.number,

    ];


    List<TextEditingController> textControllers = [
      nameController,
      sizeController,
      // Ajoutez autant de TextEditingController que nécessaire pour chaque champ de texte
    ];

    List<Widget> textFields = [];
    for (int i = 0; i < focusNodes.length; i++) {
      TextInputAction textInputAction = i < focusNodes.length - 1
          ? TextInputAction.next
          : TextInputAction.done;

      textFields.add(
        Container(
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
            keyboardType: types[i],
            focusNode: focusNodes[i],
            textInputAction: textInputAction,
            controller: textControllers[i],
            onEditingComplete: () {
              setState(() {
                if (i < focusNodes.length - 1) {
                  focusNodes[i].unfocus();
                  // Déplacez le focus vers le champ de texte suivant
                  FocusScope.of(context).requestFocus(focusNodes[i + 1]);
                } else {
                  // Vous avez atteint le dernier champ de texte
                  // Effectuez une action finale ici (par exemple, soumettre le formulaire)
                }
              });
            },
            decoration: InputDecoration(
              hintText: hintTexts[i],
              prefixIcon: Icon(icons[i], color: Colors.black,),
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
        ),
      );
      if (i < focusNodes.length - 1) {
        textFields.add(
          SizedBox(height: Dimensions.height20(context)*1.5,), // Ajoutez le SizedBox entre les champs de texte
        );
      }
    }


  
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<CultureController>(builder: (CultureController){
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.height20(context)*2,),
                //app logo
                Container(
                  height: Dimensions.screenHeight(context)*0.25,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: Dimensions.radius30(context)*2.7,
                      backgroundImage: AssetImage(
                          "assets/images/agrologo.png"
                      ),
                    ),
                  ),
                ),
                // welcome
                Text(
                  "Add a Parcel",
                  style: TextStyle(
                    fontSize: Dimensions.font20(context)*1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Dimensions.height10(context)*2,),
                Column(
                  children: textFields,
                ),
                SizedBox(height: Dimensions.height10(context)*2,),
                Container(
                  color: Colors.transparent,
                  height: Dimensions.screenHeight(context)*0.4,
                  margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.height10(context),),
                      Container(
                        height: Dimensions.screenHeight(context)*0.35,
                        color: Colors.black,
                        child: GoogleMap(
                          initialCameraPosition: initialCameraPosition,
                          mapType: MapType.normal,
                          markers: Set<Marker>.of(_markers),
                          zoomControlsEnabled: false,
                          onMapCreated: (GoogleMapController controller){
                            _controller.complete(controller);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height15(context),),
                GestureDetector(
                  onTap: (){
                    _addParcel(CultureController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth(context)/1.5,
                    height: Dimensions.screenHeight(context)/15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                      color: Color(0xFF025592),
                    ),
                    child: Center(
                      child: BigText(
                        text: "Add",
                        size: Dimensions.font20(context)*1.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },)
    );
  }


}
