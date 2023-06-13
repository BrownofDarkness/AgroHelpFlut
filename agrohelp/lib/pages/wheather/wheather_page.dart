import 'dart:convert';

import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../data/controllers/auth_controller.dart';

class WheatherPage extends StatefulWidget {
  const WheatherPage({super.key});

  @override
  State<WheatherPage> createState() => _WheatherPageState();
}

class _WheatherPageState extends State<WheatherPage> with TickerProviderStateMixin {

  late TabController _tabController;

  late bool _isloading = true;

  List<Map> Wheathers = [];

  String apikey = "acbc1629d4192a8cb3c8e6c6abd33fe0";
  //curl --compressed --request GET --url \
  // 'https://api.tomorrow.io/v4/timelines?location=40.75872069597532,-73.98529171943665&fields=temperature&timesteps=1h&units=metric&apikey=8OF93hGvm4MZ7jKchsH255VjUurSgE6Q'
  String apiUrl = 'https://api.tomorrow.io/v4/forecast';
  // ?lat=44.34&lon=10.99&appid={API key}

  Future<void> _getweather(String uri,{Map<String, String>? headers}) async {
    
    
      if (Get.find<AuthController>().wheather.isNotEmpty&&Get.find<AuthController>().wheather['parcel'] == Get.find<AuthController>().parcel&&Get.find<AuthController>().wheather['data'][0]['day'] == DateFormat('EEEE', 'fr_FR').format(DateTime.now())){
        setState(() {
          Wheathers = Get.find<AuthController>().wheather['data'];
          print('data was re used');
          _isloading = false;
        });
      }else{
        try {
          http.Response response = await http.get(
            Uri.parse(uri),
            headers: {"accept": "application/json"},
          );
          dynamic jsonData = jsonDecode(response.body);
          Map<String, dynamic> jsonMap = jsonData as Map<String, dynamic>;
          setState(() {
            for (int i = 0; i < jsonMap["timelines"]["daily"].length; i++) {
              Map wheat = {};
              //jour
              wheat["day"] = DateFormat('EEEE', 'fr_FR').format(DateTime.parse(jsonMap["timelines"]["daily"][i]["time"]));
              print('ok day $i');

              //températures
              wheat["temperature"] = {};
              wheat["temperature"]["max"] = (jsonMap["timelines"]["daily"][i]["values"]["temperatureMax"]).toInt();
              wheat["temperature"]["avg"] = (jsonMap["timelines"]["daily"][i]["values"]["temperatureAvg"]).toInt();
              wheat["temperature"]["min"] = (jsonMap["timelines"]["daily"][i]["values"]["temperatureMin"]).toInt();
              print('ok temperature $i');

              // précipitaions
              wheat["précipitations"] = {};
              wheat["précipitations"]["max"] = jsonMap["timelines"]["daily"][i]["values"]["rainIntensityMax"];
              wheat["précipitations"]["avg"] = jsonMap["timelines"]["daily"][i]["values"]["rainIntensityAvg"];
              wheat["précipitations"]["min"] = jsonMap["timelines"]["daily"][i]["values"]["rainIntensityMin"];
              print('ok pprecipitation $i');

              //vent
              wheat["vent"] = {};
              wheat["vent"]["max"] = jsonMap["timelines"]["daily"][i]["values"]["windSpeedMax"];
              wheat["vent"]["avg"] = jsonMap["timelines"]["daily"][i]["values"]["windSpeedAvg"];
              wheat["vent"]["min"] = jsonMap["timelines"]["daily"][i]["values"]["windSpeedMin"];
              print('ok vent $i');
              
              //humidité
              wheat["humidité"] = {};
              wheat["humidité"]["max"] = double.parse('${jsonMap["timelines"]["daily"][i]["values"]["humidityMax"]}');
              wheat["humidité"]["avg"] = double.parse('${jsonMap["timelines"]["daily"][i]["values"]["humidityAvg"]}');
              wheat["humidité"]["min"] = double.parse('${jsonMap["timelines"]["daily"][i]["values"]["humidityMin"]}');
              print('ok humid $i');

              Wheathers.add(wheat);
              Get.find<AuthController>().setwheather(Wheathers);
              print('ok added $i');
            }
            _isloading = false;
          });
        } catch (e) {
          print(e.toString());
        }
      }
      
  }

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Map parcel = Get.find<AuthController>().searchParcel();
    print('location=${parcel["location"][1]},${parcel["location"][0]}');
    //_getweather('$apiUrl?location=${parcel["location"][1]},${parcel["location"][0]}&timesteps=1d&units=metric&apikey=8OF93hGvm4MZ7jKchsH255VjUurSgE6Q');
    _getweather('https://api.tomorrow.io/v4/weather/forecast?location=${parcel["location"][1]}%2C${parcel["location"][0]}&timesteps=1d&units=metric&apikey=8OF93hGvm4MZ7jKchsH255VjUurSgE6Q');
  }

  late int active = 0;

  List<bool> choosed = [
    true,
    false,
    false,
    false,
    false,
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        color: Color.fromARGB(255, 43, 47, 58),
        
        child: Column(
            children: [
              SizedBox(height: Dimensions.height20(context)*2,),
                Row(
                    children: [
                      IconButton(
                        onPressed:  (){
                            Get.back();
                        }, 
                        icon: Icon(Icons.arrow_circle_left_outlined , size: Dimensions.height30(context), color: Color.fromARGB(255, 44, 131, 231),),
                      ),
                      Expanded(child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Wheather",
                            style: TextStyle(
                            fontFamily: 'Chakra_Petch',
                            fontSize: Dimensions.height20(context),
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          ),
                        ),
                      )),
                    ],
                ),
                SizedBox(height: Dimensions.height10(context),),
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height10(context)*0.3,
                  color:Color.fromARGB(255, 231, 230, 230),
                  child: Text(" "),
                ),
                _isloading?Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight(context)*0.3),
                      CircularProgressIndicator(color: Colors.amber,),
                      SizedBox(height: Dimensions.height30(context),),
                      Text(
                        "Loading Wheather",
                        style: TextStyle(
                          fontSize: Dimensions.height20(context)*1.5,
                          fontFamily: 'Chakra_Petch',
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),
                      ),
                    ],
                  )
                ):Column(
            children: [
              SizedBox(height: Dimensions.height30(context),),
              Container(
                width: Dimensions.screenWidth(context),
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      padding: EdgeInsets.only(right: Dimensions.width15(context)),
                      width: Dimensions.screenWidth(context)*0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          
                          Text(
                            "météo",
                            style: TextStyle(
                              fontSize: Dimensions.height20(context)*1.5,
                              fontFamily: 'Chakra_Petch',
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            Wheathers[active]["day"].toString(),
                            style: TextStyle(
                              fontSize: Dimensions.height20(context),
                              fontFamily: 'Chakra_Petch',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "data",
                            style: TextStyle(
                              fontSize: Dimensions.height20(context),
                              fontFamily: 'Chakra_Petch',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Container(
                width: Dimensions.screenWidth(context),
                height: Dimensions.screenHeight(context)*0.15,
                padding: EdgeInsets.only(left: Dimensions.height20(context))*0.5,
                // color: Colors.green,
                child: Row(
                  children: [
                    Row(
                        children: [
                          Container(
                            // color: Colors.amber,
                            alignment: Alignment.topLeft,
                            width: ((Dimensions.screenWidth(context)*0.6)/3)-Dimensions.width30(context)*2.5+Dimensions.width30(context),
                            child: Image.asset(
                                'assets/images/meteorology 2.png',
                                width: Dimensions.height20(context)*6,
                                height: Dimensions.height20(context)*6,
                              )
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  
                                  alignment: Alignment.center,
                                  height: Dimensions.screenHeight(context)*0.15,
                                  child: Text(
                                    Wheathers[active]["temperature"]['avg'].toString(),
                                    style: TextStyle(
                                      fontSize: Dimensions.height20(context)*2.5,
                                      fontFamily: 'Chakra_Petch',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ), 
                                  )
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: (Dimensions.screenHeight(context)*0.15),
                                  padding: EdgeInsets.only(top: Dimensions.height20(context)),
                                  child: Column(
                                    children: [
                                      Container(
                                        
                                        alignment: Alignment.topLeft,
                                        height: (Dimensions.screenHeight(context)*0.15)*0.4,
                                        child: Text(
                                            "°C",
                                            style: TextStyle(
                                              fontSize: Dimensions.height20(context)*1.5,
                                              fontFamily: 'Chakra_Petch',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ), 
                                          ),
                                      ),
                                      Expanded(child: Container(),),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Container(
                            padding: EdgeInsets.all(Dimensions.height10(context)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Précipitaions: ${Wheathers[active]["précipitations"]['avg'].toString()}%",
                                  style: TextStyle(
                                    fontSize: Dimensions.height15(context),
                                    fontFamily: 'Chakra_Petch',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ), 
                                ),
                                Text(
                                  "Humidité: ${Wheathers[active]["humidité"]['avg'].toString()} %",
                                  style: TextStyle(
                                    fontSize: Dimensions.height15(context),
                                    fontFamily: 'Chakra_Petch',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ), 
                                ),
                                Text(
                                  "Vent: ${Wheathers[active]["vent"]['avg'].toString()} km/h",
                                  style: TextStyle(
                                    fontSize: Dimensions.height15(context),
                                    fontFamily: 'Chakra_Petch',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ), 
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                width: double.maxFinite,
                // color: Colors.amber,
                child: Column(
                  children: [
                    Container(
                      // color: Color.fromARGB(255, 29, 27, 27),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)),
                      width: Dimensions.screenWidth(context),
                      child: TabBar(
                        indicatorColor: Colors.amber,
                        labelColor: Colors.white,
                        indicatorWeight: 3,
                        unselectedLabelColor: Color.fromARGB(255, 202, 199, 199),
                        controller: _tabController,
                        tabs: [
                          Tab(
                            child: Text(
                                "température",
                                style: TextStyle(
                                  fontSize: Dimensions.height15(context)*0.85,
                                  fontFamily: 'Chakra_Petch',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ), 
                              ),
                          ),
                          Tab(
                            child: Text(
                              "précipitaions",
                              style: TextStyle(
                                fontSize: Dimensions.height15(context)*0.85,
                                fontFamily: 'Chakra_Petch',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ), 
                            ),
                          ),
                          Tab(
                            child: Text(
                              "vent",
                              style: TextStyle(
                                fontSize: Dimensions.height15(context)*0.85,
                                fontFamily: 'Chakra_Petch',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ), 
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(Dimensions.height10(context)),
                      // color: Colors.green,
                      height: (Dimensions.screenHeight(context)*0.35)*0.834,
                      child: TabBarView(
                        controller: _tabController,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.8,
                                  width: Dimensions.width30(context)*8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 103, 104, 102),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                                  ),
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Maximum",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.6,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/meteorology.png',
                                          width: Dimensions.height20(context)*5,
                                          height: Dimensions.height20(context)*5,
                                        ),
                                                ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child:  Text(
                                          "${Wheathers[active]["temperature"]['max'].toString()} °C",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                                Container(
                                  height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.8,
                                  width: Dimensions.width30(context)*8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 103, 104, 102),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                                  ),
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Moyenne",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.6,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/meteorology.png',
                                          width: Dimensions.height20(context)*5,
                                          height: Dimensions.height20(context)*5,
                                        ),
                                                ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child:  Text(
                                          "${Wheathers[active]["temperature"]['avg'].toString()}°C",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                                Container(
                                  height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.8,
                                  width: Dimensions.width30(context)*8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 103, 104, 102),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                                  ),
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Minimum",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.6,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/meteorology.png',
                                          width: Dimensions.height20(context)*5,
                                          height: Dimensions.height20(context)*5,
                                        ),
                                                ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child:  Text(
                                          "${Wheathers[active]["temperature"]['min'].toString()} °C",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.8,
                                  width: Dimensions.width30(context)*8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 103, 104, 102),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                                  ),
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Maximum",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.6,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/rain.png',
                                          width: Dimensions.height20(context)*5,
                                          height: Dimensions.height20(context)*5,
                                        ),
                                                ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child:  Text(
                                          "${Wheathers[active]["précipitations"]['max'].toString()} %",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                                Container(
                                  height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.8,
                                  width: Dimensions.width30(context)*8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 103, 104, 102),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                                  ),
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Moyenne",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.6,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/rain.png',
                                          width: Dimensions.height20(context)*5,
                                          height: Dimensions.height20(context)*5,
                                        ),
                                                ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child:  Text(
                                          "${Wheathers[active]["précipitations"]['avg'].toString()} %",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                                Container(
                                  height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.8,
                                  width: Dimensions.width30(context)*8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 103, 104, 102),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                                  ),
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Minimum",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.6,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/rain.png',
                                          width: Dimensions.height20(context)*5,
                                          height: Dimensions.height20(context)*5,
                                        ),
                                                ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child:  Text(
                                          "${Wheathers[active]["précipitations"]['min'].toString()} %",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.8,
                                  width: Dimensions.width30(context)*8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 103, 104, 102),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                                  ),
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Maximum",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.6,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/windy.png',
                                          width: Dimensions.height20(context)*5,
                                          height: Dimensions.height20(context)*5,
                                        ),
                                                ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child:  Text(
                                          "${Wheathers[active]["vent"]['max'].toString()} Km/h",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                                Container(
                                  height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.8,
                                  width: Dimensions.width30(context)*8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 103, 104, 102),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                                  ),
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Moyenne",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.6,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/windy.png',
                                          width: Dimensions.height20(context)*5,
                                          height: Dimensions.height20(context)*5,
                                        ),
                                                ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child:  Text(
                                          "${Wheathers[active]["vent"]['avg'].toString()} Km/h",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                                Container(
                                  height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.8,
                                  width: Dimensions.width30(context)*8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 103, 104, 102),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                                  ),
                                  child:  Column(
                                    children: [
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Minimum",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.6,
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/windy.png',
                                          width: Dimensions.height20(context)*5,
                                          height: Dimensions.height20(context)*5,
                                        ),
                                                ),
                                      Container(
                                        height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.8)*0.2,
                                        alignment: Alignment.center,
                                        child:  Text(
                                          "${Wheathers[active]["vent"]['min'].toString()} Km/h",
                                          style: TextStyle(
                                            fontSize: Dimensions.height15(context),
                                            fontFamily: 'Chakra_Petch',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                              ],
                            ),
                          ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10(context)*0.2,child: Container(width: double.maxFinite, color: Colors.amber,),),
              SizedBox(height: Dimensions.height10(context),),
              Container(
                padding: EdgeInsets.only(left:Dimensions.height10(context), right: Dimensions.height10(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for(int i=0;i<5;i++)...[
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            active = i;
                            for(int j=0;j<5;j++){
                              if (j==i) {
                                choosed[j] = true;
                                print(choosed[j]); 
                              } else {
                                choosed[j]= false;
                              }
                            }
                          });
                        },
                        child: Container(
                          height: ((Dimensions.screenHeight(context)*0.35)*0.834)*0.5,
                          width: Dimensions.width30(context)*5,
                          decoration: BoxDecoration(
                            color: choosed[i]?Color.fromARGB(255, 138, 146, 94):Color.fromARGB(255, 103, 104, 102),
                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                          ),
                          child:  Column(
                            children: [
                              Container(
                                height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.5)*0.2,
                                alignment: Alignment.center,
                                child: Text(
                                  "${Wheathers[i]["day"].substring(0, 3)}.",
                                  style: TextStyle(
                                    fontSize: Dimensions.height15(context),
                                    fontFamily: 'Chakra_Petch',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.5)*0.6,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/storm.png',
                                  width: Dimensions.height20(context)*2.5,
                                  height: Dimensions.height20(context)*2.5,
                                ),
                                        ),
                              Container(
                                height: (((Dimensions.screenHeight(context)*0.35)*0.834)*0.5)*0.2,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left:Dimensions.height10(context)*0.8, right: Dimensions.height10(context)*0.8),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${Wheathers[i]["temperature"]['max'].toString()} °C",
                                      style: TextStyle(
                                        fontSize: Dimensions.height15(context)*0.6,
                                        fontFamily: 'Chakra_Petch',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "${Wheathers[i]["temperature"]['min'].toString()} °C",
                                      style: TextStyle(
                                        fontSize: Dimensions.height15(context)*0.6,
                                        fontFamily: 'Chakra_Petch',
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(117, 240, 236, 224),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ]
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
            ],
          ),
      ),
    );
  }
}

// class TrianglePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     path.moveTo(size.width / 2, 0);
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(TrianglePainter oldDelegate) => false;
// }

// class TriangleWidget extends StatelessWidget {
//   const TriangleWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: TrianglePainter(),
//       child: Container(
//         width: Dimensions.width30(context),
//         height: Dimensions.height30(context),
//         child: Text(" "),
//       ),
//     );
//   }
// }