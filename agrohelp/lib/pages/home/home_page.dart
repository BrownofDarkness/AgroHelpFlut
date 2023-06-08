import 'dart:async';

import 'package:agrohelp/pages/home/forum_page.dart';
import 'package:agrohelp/pages/home/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../data/controllers/auth_controller.dart';
import '../../data/controllers/culture_controller.dart';
import '../../utils/dimentions.dart';
import '../drawer/Drawer_page.dart';
import 'package:agrohelp/utils/colors.dart';


class HomePage extends StatefulWidget {
  final int id;
  const HomePage({Key? key, required this.id}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _loadressource() async {
    await Get.find<CultureController>().getRecommendedList();
    await Get.find<CultureController>().getPopularCultureList();
    await Get.find<CultureController>().getSuggestList(widget.id);
    await Get.find<AuthController>().getUser();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadressource();
    // Timer.periodic(Duration(seconds: 5), (timer) { _loadressource();});
  }
  int _selectedIndex = 0;
  // late PersistentTabController _controller;

  List title_page = [
    "Home",
    "Search",
    "Favorites",
    "Forum",
  ];

  List page = [
    // UserHomePage(),
    SearchPage(),
    Container(child: Center(child: Text("favorites page")),),
    ForumPage(),
  ];
  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
 /* @override
  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF025592),
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
                child: Text(title_page[_selectedIndex],
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
              width: Dimensions.width30(context)*3,
              child: Icon(Icons.notifications, color: Colors.white54,size: Dimensions.height30(context),),
            ),
          ],
        ),
      ),
      drawer: DrawerPage(),
      body: page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Appcolors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
            label: "home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_search, size: Dimensions.height30(context),),
            label: "search",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
            label: "favorites",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.forum),
            label: "forum",
          ),
        ],
      ),
    );
  }

  /*List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      Container(child: Center(child: Text("Next page")),),
      Container(child: Center(child: Text("Next next page")),),
      Container(child: Center(child: Text("Next next next page")),)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox_fill),
        title: ("historu"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart_fill),
        title: ("cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("me"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style5, // Choose the nav bar style with this property.
    );
  }*/

}
