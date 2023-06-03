import 'package:agrohelp/pages/home/agro_home.dart';
import 'package:agrohelp/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/controllers/auth_controller.dart';
import '../../data/controllers/culture_controller.dart';
import '../../routes/route_helper.dart';
import '../parcel/view_parcel.dart';

class Initial extends StatefulWidget {
  const Initial({super.key});

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {

  Future<void> _loadressource() async {
    await Get.find<AuthController>().getUserToken();
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadressource();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CultureController>(builder: (cultures){
        return GetBuilder<AuthController>(builder: (authcontroller){
          return (authcontroller.isconnected? ViewParcelList():AgroHome());
      });
    });
  }
}
// 