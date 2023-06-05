import 'package:agrohelp/data/controllers/culture_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/controllers/auth_controller.dart';
import '../../model/cultures_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/Recomended_item.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/fertlizer_view_item.dart';
import '../../widgets/illness_view_item.dart';

class CropDetailPage extends StatefulWidget {
  final int id;
  final String side;
  const CropDetailPage({Key? key, required this.id, required this.side}) : super(key: key);

  @override
  State<CropDetailPage> createState() => _CropDetailPageState();
}

class _CropDetailPageState extends State<CropDetailPage> {
  PageController fertiliseController = PageController(viewportFraction: 0.85);
  PageController illnessController = PageController(viewportFraction: 0.85);
  PageController soilsController = PageController(viewportFraction: 0.85);
  var _currPagevalue = 0.0;
  var _currpagevalue2 = 0.0;
  var _currpagevalue3 = 0.0;
  late bool start = false;
  double _scaleFactor = 0.8;
  double _scaleFactor2 = 0.8;
  double _scaleFactor3 = 0.8;

  double _height(BuildContext context) =>
      Dimensions.pageViewContainer(context)*0.65;

  Future<void> _loadressource(int id ) async {
    await Get.find<CultureController>().getCulturedetails(id);
  }
  
   

   
  @override
  void initState(){
    super.initState();
    fertiliseController.addListener(() {
      setState(() {
        _currPagevalue = fertiliseController.page!;
      });
    });

    illnessController.addListener(() {
      setState(() {
        _currpagevalue2 = illnessController.page!;
      });
    });

    soilsController.addListener(() {
      setState(() {
        _currpagevalue3 = soilsController.page!;
      });
    });
  }

  @override
  void dispose(){
    fertiliseController.dispose();
    illnessController.dispose();
    soilsController.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<CultureController>(builder: (cultures){
        Map culture = widget.side == "r"?cultures.suggestedcultureList[widget.id]:cultures.popularcultureList[widget.id];
        return Stack(
        children: [
          //background Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImageSize(context)+ Dimensions.height30(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(culture['culture'].photo),
                  ),
                ),
              )),
          // icon widgets
          Positioned(
              top: Dimensions.height20(context)*2.3,
              left: Dimensions.width20(context),
              right: Dimensions.width20(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios,)),
                  AppIcon(icon: Icons.add_reaction_outlined,),
                ],
              )
          ),
          // introduction of culture
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularFoodImageSize(context)-Dimensions.height20(context),
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context), top: Dimensions.height20(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius30(context)),
                      topLeft: Radius.circular(Dimensions.radius30(context))
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BigText(text: culture['culture'].name, size: Dimensions.font20(context), ),
                    BigText(text: culture['culture'].category, size: Dimensions.font16(context), ),
                    SizedBox(height: Dimensions.height10(context),),
                    Expanded(
                        child: Container(
                          width: double.maxFinite,
                          child: SingleChildScrollView(
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.only(left: Dimensions.width10(context), top: Dimensions.height10(context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(text: "Informations générales", size: Dimensions.font20(context), ),
                                    Container(
                                      child:  BigText(
                                        text: "\t\t\t${culture['culture'].description}",
                                        size: Dimensions.font16(context)*0.8,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height10(context),),
                                    BigText(text: "Pratiques agricole", size: Dimensions.font20(context), ),
                                    Container(
                                      child:Column(
                                        children: [
                                          for (int i = 0; i<cultures.cultureDetails['practises'].length;i++)...[
                                            Container(
                                              width:double.maxFinite,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(top: Dimensions.height10(context)*0.6),
                                                      child: Icon(Icons.circle, size: Dimensions.height10(context))
                                                  ), // icône de la puce
                                                  SizedBox(width: Dimensions.height10(context)*0.5),
                                                  Expanded(
                                                    child: BigText(
                                                      text: "${cultures.cultureDetails['practises'][i]['name']} : ${cultures.cultureDetails['practises'][i]['practise']}",
                                                      size: Dimensions.font16(context)*0.8,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: Dimensions.height10(context),),
                                          ]
                                        ],
                                      )
                                    ),
                                    BigText(text: "Fertilisants", size: Dimensions.font20(context), ),
                                    Text(""),
                                    Container(
                                    height: Dimensions.Pageview(context)*0.65,
                                    child: PageView.builder(
                                      controller: fertiliseController,
                                      itemCount: cultures.cultureDetails['fertilizers'].length,
                                      itemBuilder: (context, position){
                                      return _buildPageItem(position,cultures.cultureDetails['fertilizers'][position]);
                                      }
                                    ),
                                    ),
                                    SizedBox(height: Dimensions.height20(context),),
                                    BigText(text: "Maladies", size: Dimensions.font20(context), ),
                                    Text(""),
                                    Container(
                                    height: Dimensions.Pageview(context)*0.65,
                                    child: PageView.builder(
                                      controller: illnessController,
                                      itemCount: cultures.cultureDetails['diseases'].length,
                                      itemBuilder: (context, position){
                                      return _buildPageItem2(position,cultures.cultureDetails['diseases'][position]);
                                      }
                                    ),
                                    ),

                                    SizedBox(height: Dimensions.height20(context),),
                                    BigText(text: "Soles", size: Dimensions.font20(context), ),
                                    Text(""),
                                    Container(
                                    height: Dimensions.Pageview(context)*0.65,
                                    child: PageView.builder(
                                      controller: soilsController,
                                      itemCount: cultures.cultureDetails['fertilizers'].length,
                                      itemBuilder: (context, position){
                                      return _buildPageItem3(position,cultures.cultureDetails['fertilizers'][position]);
                                      }
                                    ),
                                    ),
                                    SizedBox(height: Dimensions.height10(context),)
                                  ],
                                ),
                              )
                          ),
                        )
                    )
                    ],
                ),
              )
          )
        ],
      );
      })
    );
  }
  Widget _buildPageItem(int index ,fertlise,) {
    Matrix4 matrix = Matrix4.identity();
    double currScale, currTrans;

    if (index == _currPagevalue.floor()) {
      currScale = 1 - (_currPagevalue - index) * (1 - _scaleFactor);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else if (index == _currPagevalue.floor() + 1) {
      currScale = _scaleFactor + (_currPagevalue - index + 1) * (1 - _scaleFactor);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else if (index == _currPagevalue.floor() - 1) {
      currScale = 1 - (_currPagevalue - index) * (1 - _scaleFactor);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else {
      currScale = 0.8;
      currTrans = _height(context) * (1 - currScale) / 2;
    }

    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix.setTranslationRaw(0, currTrans, 0);

    return Transform(
      transform: matrix,
      child: ViewItem(fertlizer: fertlise, index: index,),
    );
  }

  Widget _buildPageItem2(int index ,fertlise,) {
    Matrix4 matrix = Matrix4.identity();
    double currScale, currTrans;

    if (index == _currpagevalue2.floor()) {
      currScale = 1 - (_currpagevalue2 - index) * (1 - _scaleFactor2);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else if (index == _currpagevalue2.floor() + 1) {
      currScale = _scaleFactor + (_currpagevalue2 - index + 1) * (1 - _scaleFactor2);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else if (index == _currpagevalue2.floor() - 1) {
      currScale = 1 - (_currpagevalue2 - index) * (1 - _scaleFactor2);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else {
      currScale = 0.8;
      currTrans = _height(context) * (1 - currScale) / 2;
    }

    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix.setTranslationRaw(0, currTrans, 0);

    return Transform(
      transform: matrix,
      child: IllnessViewItem(illness: fertlise, index: index,),
    );
  }

  Widget _buildPageItem3(int index ,fertlise,) {
    Matrix4 matrix = Matrix4.identity();
    double currScale, currTrans;

    if (index == _currpagevalue3.floor()) {
      currScale = 1 - (_currpagevalue3 - index) * (1 - _scaleFactor3);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else if (index == _currpagevalue3.floor() + 1) {
      currScale = _scaleFactor + (_currpagevalue3 - index + 1) * (1 - _scaleFactor3);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else if (index == _currpagevalue3.floor() - 1) {
      currScale = 1 - (_currpagevalue3 - index) * (1 - _scaleFactor3);
      currTrans = _height(context) * (1 - currScale) / 2;
    } else {
      currScale = 0.8;
      currTrans = _height(context) * (1 - currScale) / 2;
    }

    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix.setTranslationRaw(0, currTrans, 0);

    return Transform(
      transform: matrix,
      child: ViewItem(fertlizer: fertlise, index: index,),
    );
  }
}
/*ListView(
padding: EdgeInsets.zero,
children: [
Container(
alignment: Alignment.center,
height: Dimensions.height30(context)*1.6,
child: ListTile(
title: Text(
'description',
style: TextStyle(
fontSize: Dimensions.height15(context),
fontFamily: 'Chakra_Petch',
fontWeight: FontWeight.w700,
),
),
onTap: () {
// Action à effectuer lorsque l'option Accueil est sélectionnée
Navigator.pop(context);// Ferme le Drawer
Get.toNamed(RouteHelper.getProfile());
// Ajoutez votre logique de navigation ici
},
),
),
Divider( // Ajoute une ligne de séparation avec une bordure en bas
color: Colors.white, // Couleur de la ligne de séparation
thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
),
Container(
height: Dimensions.height30(context)*1.6,
child: ListTile(
title: Text(
'practise',
style: TextStyle(
fontSize: Dimensions.height15(context),
fontFamily: 'Chakra_Petch',
fontWeight: FontWeight.w700,
),
),
onTap: () {
// Action à effectuer lorsque l'option Accueil est sélectionnée
// Ferme le Drawer
// Ajoutez votre logique de navigation ici
},
),
),
Divider( // Ajoute une ligne de séparation avec une bordure en bas
color: Colors.white, // Couleur de la ligne de séparation
thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
),
Container(
height: Dimensions.height30(context)*1.6,
child: ListTile(
title: Text(
'fertiliser',
style: TextStyle(
fontSize: Dimensions.height15(context),
fontFamily: 'Chakra_Petch',
fontWeight: FontWeight.w700,
),
),
onTap: () {

},
),
),
Divider( // Ajoute une ligne de séparation avec une bordure en bas
color: Colors.white, // Couleur de la ligne de séparation
thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
),
Container(
height: Dimensions.height30(context)*1.6,
child: ListTile(
title: Text(
'insecticide',
style: TextStyle(
fontSize: Dimensions.height15(context),
fontFamily: 'Chakra_Petch',
fontWeight: FontWeight.w700,
),
),
onTap: () {

},
),
),
Divider( // Ajoute une ligne de séparation avec une bordure en bas
color: Colors.white, // Couleur de la ligne de séparation
thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
),

Container(
height: Dimensions.height30(context)*1.6,
child: ListTile(
title: Text(
'soils',
style: TextStyle(
fontSize: Dimensions.height15(context),
fontFamily: 'Chakra_Petch',
fontWeight: FontWeight.w700,
),
),
onTap: () {
// Action à effectuer lorsque l'option Paramètres est sélectionnée
Navigator.pop(context); // Ferme le Drawer
// Ajoutez votre logique de navigation ici
},
),
),
Divider( // Ajoute une ligne de séparation avec une bordure en bas
color: Colors.white, // Couleur de la ligne de séparation
thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
),
Container(
height: double.maxFinite,
color: Colors.white,
),
// Ajoutez d'autres options de navigation ListTile ici
],
),*/