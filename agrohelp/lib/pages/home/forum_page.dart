import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../data/controllers/culture_controller.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  var question = TextEditingController();

  List<TextEditingController> textControllers = [];

  String tronk(text, textHeight){
    String firstHalf;
    if(text.length > textHeight){
        firstHalf = text.substring(0, textHeight.toInt())+" .....";
      }else{
        firstHalf = text;
      }
      return firstHalf;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    question.dispose();
    for (TextEditingController controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width20(context)*1.5, right: Dimensions.width20(context)*1.5, top: Dimensions.height20(context)),
      child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              height: Dimensions.height30(context)*2,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                    child: TextField(
                      cursorColor: Color(0xFF025592),
                      style: TextStyle(
                        fontFamily: 'Chakra_Petch',
                        fontSize: Dimensions.height15(context),
                        fontWeight: FontWeight.w600
                      ),
                      decoration:   InputDecoration(
                        hintText: "Ask a Question",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius20(context))*0.5,
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.grey,
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.3),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.5),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          )
                        ),
                      ),
                      controller: question,
                    )
                  )
                  ),
                  SizedBox(width:Dimensions.width10(context)),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        print("lancer la rechrche");
                      },
                      child: Text('Submit', style: TextStyle(
                        fontFamily: 'Chakra_Petch',
                        color: Colors.white,
                        fontSize: Dimensions.font16(context),
                        fontWeight: FontWeight.bold,
                      ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, 
                        minimumSize: Size(Dimensions.width20(context)*0.7, Dimensions.height30(context)*1.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height30(context),),
            GetBuilder<CultureController>(builder: (cultures){
              for (int i = 0; i < 30; i++) {
                textControllers.add(TextEditingController());
              }
              return Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 30,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        print("go on forum details $index");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context),bottom: Dimensions.height10(context)),
                        child: Container(
                          height: Dimensions.pageViewContainer(context),
                          margin: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context)*1.5),
                          width: Dimensions.pageViewContainer(context)*2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.5),
                            color: Color.fromARGB(255, 248, 247, 247),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 44, 131, 231),
                                blurRadius: 6,
                                offset: Offset(0, 3), // décalage vers le bas et la droite

                              ),
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 5,
                                offset: Offset(-2, -2), // décalage vers le haut et la gauche
                                spreadRadius: 0, // ne pas étendre l'ombre
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: Dimensions.pageViewContainer(context)*0.20,
                                padding: EdgeInsets.only(left: Dimensions.width10(context)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20(context)*0.5), topRight: Radius.circular(Dimensions.radius20(context)*0.5)),
                                  color: Color.fromARGB(255, 248, 247, 247),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 44, 131, 231),
                                      blurRadius: 6,
                                      offset: Offset(1, 0), // décalage vers le bas et la droite

                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 5,
                                      offset: Offset(0, 2), // décalage vers le haut et la gauche
                                      spreadRadius: 0, // ne pas étendre l'ombre
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.edit_calendar_outlined, size: Dimensions.height20(context)*1.5,),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: Dimensions.width10(context)),
                                        child: Text("the question's autor"),
                                      )
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: Dimensions.pageViewContainer(context)*0.20,
                                      width: (Dimensions.pageViewContainer(context)*2)*0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20(context)*0.5)),
                                        color: Color.fromARGB(255, 248, 247, 247)                                  ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: Dimensions.width20(context),),
                                          Text("12"),
                                          Icon(Icons.edit_document, size: Dimensions.height20(context)*1.2,)
                                        ],
                                      ),
                                    ),
                                  ]
                                ),
                              ),
                              Container(
                                height: Dimensions.pageViewContainer(context)*0.55,
                                padding: EdgeInsets.only(left: Dimensions.width10(context), right: Dimensions.width10(context), top: Dimensions.width10(context)),
                                child: Text(
                                  tronk("kfhdfjvghjgfhjvgdhfvgdhjhfdjvfdgvhfvhfdHgsHsxgqxgsqhdhqdgshdfshdhjdghsdfsghdshgdfgsdfghdsgqsqvdhqvdhsdfshdsugzeuzgezgyzqxcqgfxcsqgfxcsxgfcgfcsfxgcsfgxcsgfxcqfgxscgfcsgfx", Dimensions.pageViewContainer(context)*0.55),
                                  style: TextStyle(
                                        fontFamily: 'Chakra_Petch',
                                        fontSize: Dimensions.height15(context)*1.2,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.radius20(context)*0.5), bottomRight: Radius.circular(Dimensions.radius20(context)*0.5)),
                                  color: Color.fromARGB(255, 44, 131, 231),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: Dimensions.height10(context)*0.5,),
                                      Expanded(
                                        child: Container(
                                          height: Dimensions.height20(context)*2,
                                        child: TextField(
                                          controller: textControllers[index],
                                          maxLines: null,
                                          onSubmitted: (String value) {
                                            textControllers[index].text += '\n';
                                          },
                                          cursorColor: Color(0xFF025592),
                                          style: TextStyle(
                                            fontFamily: 'Chakra_Petch',
                                            fontSize: Dimensions.height15(context),
                                            fontWeight: FontWeight.w600
                                          ),
                                          decoration:   InputDecoration(
                                            contentPadding: EdgeInsets.only(top: Dimensions.height10(context)*0.5, left: Dimensions.height10(context)*0.8),
                                            hintText: "make a comment",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20(context))*0.5,
                                              borderSide: BorderSide(
                                                width: 2.0,
                                                color: Color.fromARGB(255, 44, 131, 231),
                                              )
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.3),
                                              borderSide: BorderSide(
                                                width: 1.0,
                                                color: Color.fromARGB(255, 44, 131, 231),
                                              )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.5),
                                              borderSide: BorderSide(
                                                width: 1.0,
                                                color: Color.fromARGB(255, 44, 131, 231),
                                              )
                                            ),
                                          ),
                                        )
                                      )
                                      ),
                                      Container(
                                        child: IconButton(
                                          onPressed: () {
                                            print(textControllers[index].text);
                                            textControllers[index].clear();
                                          },
                                          icon: Icon(Icons.send),
                                          iconSize: Dimensions.height20(context),
                                          color: Color(0xFF025592),
                                        )
                                       ),
                                    ],
                                  ),
                                  
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                }),
              )
            );
            }),
            
          ],
        ),
    );
  }
}