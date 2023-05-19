import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class CropDetailPage extends StatefulWidget {
  final int id;
  const CropDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CropDetailPage> createState() => _CropDetailPageState();
}

class _CropDetailPageState extends State<CropDetailPage> {
   List<String> items = [
     "Ombrage : Plantez des arbres d'ombrage pour protéger les jeunes plants de cacao du soleil direct.",
     "Gestion de l'humidité : Assurez-vous que les plants de cacao reçoivent une irrigation adéquate et évitez les excès d'eau stagnante.",
     "Pollinisation : Favorisez la pollinisation manuelle ou en encourageant la présence de pollinisateurs naturels, tels que les insectes et les abeilles.",
     "Pollinisation manuelle : Dans certaines régions, la pollinisation manuelle peut être nécessaire pour augmenter le taux de nouaison des fleurs de cacao et assurer une meilleure production.",
     "Contrôle des ravageurs : Surveillez et prenez des mesures de lutte contre les ravageurs tels que les ravageurs des capsules de cacao et les champignons pathogènes pour préserver la santé des arbres.",
     "Fermentation des fèves : Après la récolte, fermez les fèves de cacao dans des sacs ou des caisses pendant quelques jours pour permettre la fermentation, ce qui améliore la saveur et le développement des arômes."
   ];
   PageController fertiliseController = PageController(viewportFraction: 0.85);
   PageController insectController = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImageSize(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/funfood.jpeg",
                    ),
                  ),
                ),
              )),
          // icon widgets
          Positioned(
              top: Dimensions.height20(context) + Dimensions.height15(context),
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
          // introduction of food
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularFoodImageSize(context)-Dimensions.height20(context),
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20(context), right: Dimensions.width20(context), top: Dimensions.height20(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20(context)),
                      topLeft: Radius.circular(Dimensions.radius20(context))
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BigText(text: "Cacao (Theobroma cacao)", size: Dimensions.font20(context), ),
                    BigText(text: "Culture commerciale", size: Dimensions.font16(context), ),
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
                                        text: "\t\t\tLe cacao est cultivé pour ses fèves, qui sont essentielles pour la production de chocolat. Les arbres de cacao sont originaires des régions tropicales et subtropicales et se développent dans des sols riches en matière organique et bien drainés.\nLes fèves de cacao sont récoltées des cabosses, qui sont des fruits allongés. Après fermentation et séchage, les fèves sont transformées en poudre de cacao et en beurre de cacao, utilisés dans la fabrication de chocolat et d'autres produits à base de cacao.",
                                        size: Dimensions.font16(context)*0.8,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height10(context),),
                                    BigText(text: "Pratiques agricole", size: Dimensions.font20(context), ),
                                    Container(
                                      child:Column(
                                        children: [
                                          for (int i = 0; i<items.length;i++)...[
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
                                                      text: items[i],
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

                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
                                    Text("djjdfdfgdhgfdhf"),
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
      ),
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