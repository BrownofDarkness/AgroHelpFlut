import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../data/controllers/auth_controller.dart';
import '../../utils/dimentions.dart';
import '../../utils/colors.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/big_text.dart';
import '../../widgets/app_icon.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 46, 121, 175), // Couleur de la flèche
        ),
        backgroundColor: Appcolors.mainColor,
        title: Center(
          child: BigText(
            text: "Profile",size: Dimensions.height20(context)*1.25,
            color: Colors.white ,
          ),
        ),
      ),
      
      body: GetBuilder<AuthController>(builder: (authcontroller){
        var user = authcontroller.user;
        return Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20(context)),
        child: Column(
          children: [
            AppIcon(icon: Icons.person,
              backgroundColor: Appcolors.mainColor,
              iconColor: Colors.white,
              iconsize: Dimensions.height30(context)*2+Dimensions.height15(context),
              size: Dimensions.height30(context)*5,
            ),
            SizedBox(height: Dimensions.height30(context),),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: Appcolors.mainColor,
                        iconColor: Colors.white,
                        iconsize: Dimensions.height10(context)*5/2,
                        size: Dimensions.height10(context)*5,
                      ),
                      bigText: BigText(text: user.username,),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.email,
                        backgroundColor: Appcolors.yellowColor,
                        iconColor: Colors.white,
                        iconsize: Dimensions.height10(context)*5/2,
                        size: Dimensions.height10(context)*5,
                      ),
                      bigText: BigText(text: user.email,),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.type_specimen_outlined,
                        backgroundColor: Appcolors.paraColor,
                        iconColor: Colors.white,
                        iconsize: Dimensions.height10(context)*5/2,
                        size: Dimensions.height10(context)*5,
                      ),
                      bigText: BigText(text: user.type,),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.tips_and_updates_outlined,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        iconsize: Dimensions.height10(context)*5/2,
                        size: Dimensions.height10(context)*5,
                      ),
                      bigText: BigText(text: "update your profile",),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                  ],
                ),
              ),
            )
          ],
        ),
      );
      }),
    );
  }
}
