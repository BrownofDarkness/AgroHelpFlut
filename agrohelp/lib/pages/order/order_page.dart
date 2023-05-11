import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimentions.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState(){
    super.initState();
    _isLoggedIn = true;
    if(_isLoggedIn){
      _tabController = TabController(length: 2, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.mainColor,
        title: Center(child: Text("my orders"),),
      ),
      body: Column(
      children: [
        Container(
          width: Dimensions.screenWidth(context),
          child: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            indicatorWeight: 3,
            unselectedLabelColor: Appcolors.yellowColor,
            controller: _tabController,
            tabs: [
              Tab(text: "Current",),
              Tab(text: "History",),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
              children: [
                Text("current"),
                Text("current history"),
              ],
          ),
        )
    ],
    ),
    );
  }
}
