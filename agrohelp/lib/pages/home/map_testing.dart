import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/dimentions.dart';

class MapTesting extends StatefulWidget {
  const MapTesting({super.key});

  @override
  State<MapTesting> createState() => _MapTestingState();
}

class _MapTestingState extends State<MapTesting> {

  late GoogleMapController googlemapController ;

  
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

  

  bool isMapCreated = false;

  // Animation de la caméra vers une position donnée
  void animateToPosition(LatLng targetPosition) {
    googlemapController.animateCamera(
      CameraUpdate.newLatLng(targetPosition),
    );
  }

  Future<Position> getUserCurrentLocation() async{

    await Geolocator.requestPermission().then((value) => {

    });

    return await Geolocator.getCurrentPosition();
  }  

  loadPosition(){
    getUserCurrentLocation().then((value) async{
      print("my current location");
      print(value.latitude.toString()+" "+ value.longitude.toString());
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
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Color.fromARGB(255, 15, 92, 17),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.back_hand, color: Colors.white54,size: Dimensions.height30(context),),
              onPressed: () {
               Get.back();
              },
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text("Home",
                  style: TextStyle(
                    fontFamily: 'Chakra_Petch',
                    color: Colors.white60,
                    fontSize: Dimensions.height20(context),
                  ),
                  overflow: TextOverflow.visible,
                ),

              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: Dimensions.width30(context)*8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){
                          print("wheather");
                          
                        },
                        icon: Icon(Icons.cloud, color: Colors.white54,size: Dimensions.height30(context),),
                      ),
                    
                    ],
                  ),
                  IconButton(
                    onPressed: (){
                      print("dialog");
                    },
                    icon: Icon(Icons.notifications, color: Colors.white54,size: Dimensions.height30(context),),
                  )
                ],
              )
            ),
          ],
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_markers),
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadPosition();
        },
        child: Icon(Icons.local_activity),
        
      ), 
    );
  }
}