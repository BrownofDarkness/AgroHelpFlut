import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_icon.dart';

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
    late  bool _isTextEntered= false;
    String selectedOption = ""; //  =variable pour stocker la valeur sélectionnée

    List<String> options = ['culture', 'maladie',"insecticide"];
    List<DropdownMenuItem<String>> dropdownOptions = options
        .map((String option) => DropdownMenuItem<String>(
      value: option,
      child: Text(option,),
    ))
        .toList();// liste des options
    return Scaffold(
      body: Container(
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
                      color: Color(0xFF025592),
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
                      dropdownColor: Color(0xFF025592),
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
                      cursorColor: Color(0xFF025592),
                      style: TextStyle(
                          fontFamily: 'Chakra_Petch',
                        fontSize: Dimensions.height15(context)*1.2,
                        fontWeight: FontWeight.w600
                      ),
                      decoration:   InputDecoration(
                        hintText: "Rechercher",
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF025592)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF025592)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF025592)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: Color(0xFF025592),),
                          onPressed: () {
                            setState(() {
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
          ],
        ),
      ),
    );
  }
}
