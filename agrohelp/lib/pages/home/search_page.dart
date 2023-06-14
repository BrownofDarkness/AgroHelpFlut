import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../data/controllers/culture_controller.dart';
import '../../widgets/big_text.dart';
import '../../widgets/search/search_culture_item.dart';
import '../../widgets/search/search_fertilizer_item.dart';
import '../../widgets/search/search_maladie_item.dart';
import '../../widgets/small_text.dart';
import '../drawer/Drawer_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String selectedOption = ""; //  =variable pour stocker la valeur sélectionnée

    List<String> options = ['culture', 'maladie',"fertlisant"];
    List<DropdownMenuItem<String>> dropdownOptions = options
        .map((String option) => DropdownMenuItem<String>(
      value: option,
      child: Text(option,),
    ))
        .toList();// liste des options

    Future<void> _search(String filter, String content, CultureController controller) async {
      await controller.searchResult(filter, content);
    }
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
                child: Text("Search Page",
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
      
      body: GetBuilder<CultureController>(builder: (cultures){
          return Container(
            height: double.maxFinite,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  height: Dimensions.height30(context)*2,
                  child: Row(
                    children: [
                      Container(
                        width: Dimensions.width30(context)*8.5,
                        margin: EdgeInsets.only(left: Dimensions.width10(context)),
                        padding: EdgeInsets.only(left: Dimensions.width10(context)*2),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 15, 92, 17),
                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20(context)))
                        ),
                        child: DropdownButtonFormField<String>(
                          style: TextStyle(
                            fontFamily: 'Chakra_Petch',
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "filter",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Chakra_Petch',
                              fontWeight: FontWeight.w600,
                            ),
                            fillColor: Colors.white
                          ),
                          dropdownColor: Color.fromARGB(255, 15, 92, 17),
                          icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                          iconSize: Dimensions.height30(context),
                          isExpanded: true,
                          items: dropdownOptions,

                          onChanged: (String? value) {
                            selectedOption = value.toString().isEmpty?selectedOption: value.toString();
                            print(selectedOption);
                          },
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.grey,
                        indent: Dimensions.height10(context),
                        endIndent: Dimensions.height10(context),

                      ),
                      Expanded(child: Container(
                        child: TextField(
                          cursorColor: Color.fromARGB(255, 15, 92, 17),
                          style: TextStyle(
                              fontFamily: 'Chakra_Petch',
                            fontSize: Dimensions.height15(context)*1.2,
                            fontWeight: FontWeight.w600
                          ),
                          decoration:   InputDecoration(
                            hintText: "Rechercher",
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 15, 92, 17)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 15, 92, 17)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 15, 92, 17)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search, color: Color.fromARGB(255, 15, 92, 17),),
                              onPressed: () {
                                setState(() {
                                  _search(selectedOption, search.text.trim(), cultures);
                                  search.clear();
                                });
                              },
                            ),
                          ),
                          controller: search,
                        )
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: cultures.searching? CircularProgressIndicator():SingleChildScrollView(
                    child: Column(
                      children: [
                        for(int i=0; i<cultures.search["results"].length;i++)...[
                          if (cultures.search["filter"] == "culture")...[
                            SearchCultureItem(culture:cultures.search["results"][i], index: i,)
                          ],
                          if (cultures.search["filter"] == "maladie")...[
                            SearchMaladieItem(diesease:cultures.search["results"][i])
                          ],
                          if (cultures.search["filter"] == "fertlisant")...[
                            SearchFertilizerItem(fertilizer: cultures.search["results"][i])
                          ] 
                          
                        ]
                        
                      ],
                    )
                  )
                ),
              
              ],
            ),
          );
      }),
    );
  }
}
