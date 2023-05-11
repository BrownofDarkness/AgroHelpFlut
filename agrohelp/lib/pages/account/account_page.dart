import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Appcolors.mainColor,
        title: Center(
          child: BigText(
            text: "Profile",size: Dimensions.height20(context)*1.25,
            color: Colors.white ,
          ),
        ),
      ),
      body: Container(
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
                      bigText: BigText(text: "Ahmed",),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.phone,
                        backgroundColor: Appcolors.yellowColor,
                        iconColor: Colors.white,
                        iconsize: Dimensions.height10(context)*5/2,
                        size: Dimensions.height10(context)*5,
                      ),
                      bigText: BigText(text: "656614565",),
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
                      bigText: BigText(text: "takoubrown@gmail.com",),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        backgroundColor: Appcolors.yellowColor,
                        iconColor: Colors.white,
                        iconsize: Dimensions.height10(context)*5/2,
                        size: Dimensions.height10(context)*5,
                      ),
                      bigText: BigText(text: "Fill in your adress",),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message_outlined,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        iconsize: Dimensions.height10(context)*5/2,
                        size: Dimensions.height10(context)*5,
                      ),
                      bigText: BigText(text: "Ahmed",),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message_outlined,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        iconsize: Dimensions.height10(context)*5/2,
                        size: Dimensions.height10(context)*5,
                      ),
                      bigText: BigText(text: "Ahmed",),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message_outlined,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        iconsize: Dimensions.height10(context)*5/2,
                        size: Dimensions.height10(context)*5,
                      ),
                      bigText: BigText(text: "Ahmed",),
                    ),
                    SizedBox(height: Dimensions.height30(context),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
