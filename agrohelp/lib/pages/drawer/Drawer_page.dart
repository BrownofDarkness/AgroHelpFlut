import 'package:agrohelp/pages/home/initial.dart';
import 'package:agrohelp/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/controllers/auth_controller.dart';
import '../../helper/text_cliper.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<AuthController>(builder: (authcontroller){
        return ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: Dimensions.height30(context)*5, // Modifier la hauteur du DrawerHeader ici
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF025592),
              ),
              child: Container(
                width: double.infinity,
                height: Dimensions.height30(context)*5,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: Dimensions.height30(context)*6,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white,size: Dimensions.height20(context)*3,),
                          ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Dimensions.height10(context),),
                            Text(
                              clipper(15,authcontroller.user.username,Dimensions.width30(context)*2),
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Chakra_Petch',
                                fontSize: Dimensions.height15(context),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: Dimensions.height10(context),),
                            Text(
                              authcontroller.user.type??"agriculteur",
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Chakra_Petch',
                                fontSize: Dimensions.height20(context)*0.8,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: Dimensions.height30(context)*1.6,
            child: ListTile(
              leading: Icon(Icons.person, size: Dimensions.height30(context),),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: Dimensions.height20(context),
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
            color: Colors.grey, // Couleur de la ligne de séparation
            thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
            indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
            endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
          ),
          Container(
            height: Dimensions.height30(context)*1.6,
            child: ListTile(
              leading: Icon(Icons.home, size: Dimensions.height30(context),),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: Dimensions.height20(context),
                  fontFamily: 'Chakra_Petch',
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                // Action à effectuer lorsque l'option Accueil est sélectionnée
                Navigator.pop(context);// Ferme le Drawer
                Get.toNamed(RouteHelper.getUserHome());
                // Ajoutez votre logique de navigation ici
              },
            ),
          ),
          Divider( // Ajoute une ligne de séparation avec une bordure en bas
            color: Colors.grey, // Couleur de la ligne de séparation
            thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
            indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
            endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
          ),
          Container(
            height: Dimensions.height30(context)*1.6,
            child: ListTile(
              leading: Icon(Icons.manage_search_outlined, size: Dimensions.height30(context),),
              title: Text(
                'Search Page',
                style: TextStyle(
                  fontSize: Dimensions.height20(context),
                  fontFamily: 'Chakra_Petch',
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                // Action à effectuer lorsque l'option Accueil est sélectionnée
                Navigator.pop(context);
                Get.toNamed(RouteHelper.getSearchpage());// Ferme le Drawer
                // Ajoutez votre logique de navigation ici
              },
            ),
          ),
          Divider( // Ajoute une ligne de séparation avec une bordure en bas
            color: Colors.grey, // Couleur de la ligne de séparation
            thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
            indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
            endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
          ),
          Container(
            height: Dimensions.height30(context)*1.6,
            child: ListTile(
              leading: Icon(Icons.star, size: Dimensions.height30(context),),
              title: Text(
                'Favorites crops',
                style: TextStyle(
                  fontSize: Dimensions.height20(context),
                  fontFamily: 'Chakra_Petch',
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                // Action à effectuer lorsque l'option Accueil est sélectionnée
                Navigator.pop(context);// Ferme le Drawer
                // Ajoutez votre logique de navigation ici
              },
            ),
          ),
          Divider( // Ajoute une ligne de séparation avec une bordure en bas
            color: Colors.grey, // Couleur de la ligne de séparation
            thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
            indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
            endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
          ),
          Container(
            height: Dimensions.height30(context)*1.6,
            child: ListTile(
              leading: Icon(Icons.forum, size: Dimensions.height30(context),),
              title: Text(
                'Forum Page',
                style: TextStyle(
                  fontSize: Dimensions.height20(context),
                  fontFamily: 'Chakra_Petch',
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                // Action à effectuer lorsque l'option Accueil est sélectionnée
                Navigator.pop(context);
                Get.toNamed(RouteHelper.getforumPage());// Ferme le Drawer
                // Ajoutez votre logique de navigation ici
              },
            ),
          ),
          Divider( // Ajoute une ligne de séparation avec une bordure en bas
            color: Colors.grey, // Couleur de la ligne de séparation
            thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
            indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
            endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
          ),
          Container(
            height: Dimensions.height30(context)*1.6,
            child: ListTile(
              leading: Icon(Icons.settings, size: Dimensions.height30(context),),
              title: Text(
                'Seetings',
                style: TextStyle(
                  fontSize: Dimensions.height20(context),
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
            color: Colors.grey, // Couleur de la ligne de séparation
            thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
            indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
            endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
          ),
          Container(
            height: Dimensions.height30(context)*1.6,
            child: ListTile(
              leading: Icon(Icons.maps_home_work_rounded, size: Dimensions.height30(context),),
              title: Text(
                'ParcelView',
                style: TextStyle(
                  fontSize: Dimensions.height20(context),
                  fontFamily: 'Chakra_Petch',
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                // Action à effectuer lorsque l'option Accueil est sélectionnée
                Navigator.pop(context);
                Get.toNamed(RouteHelper.getParcelView());// Ferme le Drawer
                // Ajoutez votre logique de navigation ici
              },
            ),
          ),
          Divider( // Ajoute une ligne de séparation avec une bordure en bas
            color: Colors.grey, // Couleur de la ligne de séparation
            thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
            indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
            endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
          ),
          Container(
            height: Dimensions.height30(context)*5.5,
            color: Colors.white,
            // Autres propriétés du Container
          ),
          Divider( // Ajoute une ligne de séparation avec une bordure en bas
            color: Colors.grey, // Couleur de la ligne de séparation
            thickness: Dimensions.height10(context)*0.1, // Épaisseur de la ligne de séparation
            indent: Dimensions.width10(context), // Retrait de la ligne de séparation à gauche
            endIndent: Dimensions.width10(context), // Retrait de la ligne de séparation à droite
          ),
          Container(
              height: Dimensions.height30(context)*1.6,
              child: ListTile(
                leading: Icon(Icons.logout_outlined, color: Colors.red, size: Dimensions.height30(context),),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: Dimensions.height20(context),
                    fontFamily: 'Chakra_Petch',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onTap: () {
                  // Action à effectuer lorsque l'option Paramètres est sélectionnée
                  Navigator.pop(context);  // Ferme le Drawer
                  authcontroller.clearSharedData();
                  Get.toNamed(RouteHelper.getInitial());
                  // Ajoutez votre logique de navigation ici
                },
              ),
            ),
          // Ajoutez d'autres options de navigation ListTile ici
        ],
      );
      }
    )
    );
  }
}
