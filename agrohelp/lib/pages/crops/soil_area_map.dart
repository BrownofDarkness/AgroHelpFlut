import 'dart:async';

import 'package:agrohelp/data/controllers/culture_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/controllers/auth_controller.dart';
import '../../utils/dimentions.dart';

class SoilAreaMap extends StatefulWidget {
  final int soil;
  const SoilAreaMap({super.key, required this.soil});

  @override
  State<SoilAreaMap> createState() => _SoilAreaMapState();
}

class _SoilAreaMapState extends State<SoilAreaMap> {

  Completer<GoogleMapController> _controller = Completer();

  Map parcel = Get.find<AuthController>().searchParcel();
  late Map soil; 
  late List<LatLng> polygonPoints = [];

  static late CameraPosition initialCameraPosition; 

  final List<Marker> _markers = <Marker>[ ];
  late Polygon polygon ;
  late Set<Polygon> polygons ;

  @override
  void initState(){
    super.initState();
    soil = Get.find<CultureController>().cultureDetails['soils'][widget.soil];
    soil['area'].forEach((item){
      polygonPoints.add(
        LatLng(item[1], item[0])
      );
    });
    print(polygonPoints[0].latitude);
    polygon = Polygon(
      polygonId: PolygonId('2'),
      points: polygonPoints,
      strokeWidth: 2,
      strokeColor: Colors.red,
      fillColor: Colors.blue.withOpacity(0.3),
    );
    polygons = Set.from([polygon]);
    initialCameraPosition = CameraPosition( target: LatLng(parcel["location"][1], parcel["location"][0]), zoom: 8.0, ); 
    _markers.add(
      Marker(
      markerId: MarkerId("1"),
      position: LatLng(parcel["location"][1], parcel["location"][0]),
      infoWindow: InfoWindow(
        title: "your parcel position"
      ),
      
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Color.fromARGB(255, 15, 92, 17),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white54,size: Dimensions.height30(context),),
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
                child: Text("favorable soil area",
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
              child: IconButton(
                    onPressed: (){
                      print("dialog");
                    },
                    icon: Icon(Icons.notifications, color: Colors.white54,size: Dimensions.height30(context),),
                  )
            ),
          ],
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_markers),
        polygons: polygons,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
       
    );
  }
}