import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../base/show_custom_snackBar.dart';
import '../../data/controllers/auth_controller.dart';
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
  var mapController = MapController();
  LatLng _selectedPoint = LatLng(0, 0);
  LatLng _currentPosition = LatLng(0, 0);
  @override
  Widget build(BuildContext context) {

    void _login(AuthController authController){
      String name = nameController.text.trim();
      String size = sizeController.text.trim();
      if(name.isEmpty){
        ShowCustomSnackBar("type in an parcel name adress", title: "Parcel Name");
      }else if(size.isEmpty) {
        ShowCustomSnackBar("type in your parcel size", title: "Parcel size");
      }else{
        ShowCustomSnackBar("All went well", title: "Perfect");
        authController.login(name, size).then((status) {
          if(status.isSucess==true){
            print("Success login");
          }else{
            ShowCustomSnackBar(status.message,);
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

    Future<void> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _selectedPoint == LatLng(0, 0);
        _currentPosition = LatLng(position.latitude, position.longitude) ;
      });
    }

    double _zoomLevel = 8.0;

    void _handleTap(LatLng point) {
      setState(() {
        _selectedPoint = point;
      });
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authcontroller){
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
                  height: Dimensions.screenHeight(context)*0.33,
                  margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: (Dimensions.screenHeight(context)*0.3)*0.1,
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            Container(
                              alignment: Alignment.center,
                              width: Dimensions.height30(context)*3.5,
                              height: Dimensions.height30(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20(context)),
                                color: Color(0xFF025592),
                              ),
                              child: GestureDetector(
                                // onTap: _determinePosition(),
                                child: Text(
                                  "geolocation",
                                  style: TextStyle(
                                      fontSize: Dimensions.height15(context),
                                      fontFamily: 'Chakra_Petch',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.height10(context),),
                      Expanded(
                          child: Container(
                            color: Colors.black,
                            child: FlutterMap(
                              mapController: mapController,
                              options: MapOptions(
                                onTap:(position, point){
                                  setState(() {
                                    _selectedPoint = point;
                                  });
                                  print(point);
                                } ,
                                onMapReady: () {
                                  mapController.mapEventStream.listen((evt) {});
                                  // And any other `MapController` dependent non-movement methods
                                },
                                center: _currentPosition != LatLng(0, 0)?_currentPosition:LatLng(3.866667, 11.516667),
                                zoom: 7,
                              ),

                              children: [
                                TileLayer(
                                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  subdomains: const ['a', 'b', 'c'],
                                  userAgentPackageName: 'net.tlserver6y.flutter_map_location_marker.example',
                                  maxZoom: 19,
                                ),
                                CurrentLocationLayer(
                                  followOnLocationUpdate: FollowOnLocationUpdate.always,
                                  turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                                  style: LocationMarkerStyle(
                                    marker: const DefaultLocationMarker(
                                      child: Icon(
                                        Icons.navigation,
                                        color: Colors.white,
                                      ),
                                    ),
                                    markerSize: const Size(40, 40),
                                    markerDirection: MarkerDirection.heading,
                                  ),
                                ),
                                MarkerLayer(
                                  markers: [
                                    if (_selectedPoint != LatLng(0, 0))
                                      Marker(
                                        point: _selectedPoint,
                                        builder: (context) => Icon(Icons.location_on, color: Colors.green),
                                      ),
                                    if (_currentPosition != LatLng(0, 0))
                                      Marker(
                                        point: _currentPosition,
                                        builder: (context) => Icon(Icons.location_on, color: Colors.blue),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight(context)*0.035,),
                GestureDetector(
                  onTap: (){
                    _login(authcontroller);
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
