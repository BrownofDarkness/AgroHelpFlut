import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/material.dart';

import '../drawer/Drawer_page.dart';

class FavoriteCropsPage extends StatefulWidget {
  const FavoriteCropsPage({super.key});

  @override
  State<FavoriteCropsPage> createState() => _FavoriteCropsPageState();
}

class _FavoriteCropsPageState extends State<FavoriteCropsPage> with TickerProviderStateMixin {



  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 15, 92, 17),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white54,size: Dimensions.height30(context),),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Ouvre le drawer
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
                child: Text("favorite Crops",
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
              width: Dimensions.width30(context)*6,
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
      drawer: DrawerPage(),
      body: Container(
        width: double.maxFinite,
        color: Colors.white,
      ),
    );
  }
}