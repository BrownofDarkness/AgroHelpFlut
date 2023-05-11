import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agrohelp/widgets/app_icon.dart';
import 'package:agrohelp/widgets/big_text.dart';

import '../utils/dimentions.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;
  const AccountWidget({Key? key,required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width10(context),
      top: Dimensions.height10(context),
      bottom: Dimensions.height10(context)
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20(context),),
          bigText
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
    );
  }
}
