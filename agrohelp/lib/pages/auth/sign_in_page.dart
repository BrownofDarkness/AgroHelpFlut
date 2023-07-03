import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackBar.dart';
import '../../data/controllers/auth_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimentions.dart';

import '../../utils/colors.dart';

import '../../widgets/big_text.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({Key? key}) : super(key: key);

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var emailfocus = FocusNode();
  var passwordfocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    void _login(AuthController authController) {
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      if (email.isEmpty) {
        ShowCustomSnackBar("type in your email adress", title: "Email adress");
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomSnackBar("type in a valid email adress",
            title: "Email adress");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("type in your password", title: "Password");
      } else if (password.length < 6) {
        ShowCustomSnackBar("password can not be less than six characters",
            title: "Password");
      } else {
        ShowCustomSnackBar("All went well", title: "Perfect", isError: false);
        authController.login(email, password).then((status) {
          if (status.isSucess == true) {
            ShowCustomSnackBar("user was successfully logged in ",
                title: "sing in", isError: false);
            Get.toNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(
              status.message,
            );
          }
        });
      }
    }

    List<FocusNode> focusNodes = [
      emailfocus,
      passwordfocus,
    ];

    List<bool> obscured = [
      false,
      true,
    ];

    List<String> hintTexts = [
      "Email",
      "Password",
    ];

    List<IconData> icons = [
      Icons.person_outline,
      Icons.alternate_email,
      Icons.lock_outlined,
    ];

    List<TextEditingController> textControllers = [
      emailController,
      passwordController,
      // Ajoutez autant de TextEditingController que nécessaire pour chaque champ de texte
    ];

    List<Widget> textFields = [];
    for (int i = 0; i < focusNodes.length; i++) {
      TextInputAction textInputAction = i < focusNodes.length - 1
          ? TextInputAction.next
          : TextInputAction.done;

      textFields.add(
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.height20(context) * 2,
              right: Dimensions.height20(context) * 2),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Dimensions.radius20(context) * 0.5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF02690C),
                  blurRadius: 6,
                  offset: Offset(0, 3), // décalage vers le bas et la droite
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 5,
                  offset: Offset(-2, -2), // décalage vers le haut et la gauche
                  spreadRadius: 0, // ne pas étendre l'ombre
                ),
              ]),
          child: TextField(
            obscureText: obscured[i],
            focusNode: focusNodes[i],
            textInputAction: textInputAction,
            controller: textControllers[i],
            onEditingComplete: () {
              setState(() {
                if (i < focusNodes.length - 1) {
                  focusNodes[i].unfocus();
                  // Déplacez le focus vers le champ de texte suivant
                  FocusScope.of(context).requestFocus(focusNodes[i + 1]);
                } else {
                  // Vous avez atteint le dernier champ de texte
                  // Effectuez une action finale ici (par exemple, soumettre le formulaire)
                }
              });
            },
            decoration: InputDecoration(
              hintText: hintTexts[i],
              prefixIcon: Icon(
                icons[i],
                color: Colors.black,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Dimensions.radius20(context)) * 0.5,
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.white,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Dimensions.radius30(context)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )),
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Dimensions.radius30(context)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      );
      if (i < focusNodes.length - 1) {
        textFields.add(
          SizedBox(
            height: Dimensions.height30(context) * 1.5,
          ), // Ajoutez le SizedBox entre les champs de texte
        );
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authcontroller) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.height20(context) * 2,
                  ),
                  //app logo
                  Container(
                    height: Dimensions.screenHeight(context) * 0.25,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: Dimensions.radius30(context) * 2.7,
                        backgroundImage:
                            AssetImage("assets/images/agrologo.png"),
                      ),
                    ),
                  ),
                  // welcome
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: Dimensions.font20(context) * 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20(context) * 2,
                  ),
                  Column(
                    children: textFields,
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight(context) * 0.08,
                  ),
                  GestureDetector(
                    onTap: () {
                      _login(authcontroller);
                    },
                    child: Container(
                      width: Dimensions.screenWidth(context) / 1.5,
                      height: Dimensions.screenHeight(context) / 15,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30(context)),
                        color: Color(0xFF025592),
                      ),
                      child: Center(
                        child: BigText(
                          text: "Sing In",
                          size: Dimensions.font20(context) * 1.3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight(context) * 0.03,
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight(context) * 0.03,
                  ),
                  RichText(
                    text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(RouteHelper.getRegister()),
                      text: "Forgot Password?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight(context) * 0.03,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Don\'t have an account?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20(context),
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Get.toNamed(RouteHelper.getRegister()),
                            text: "Create",
                            style: TextStyle(
                                color: Appcolors.mainBlackColor,
                                fontSize: Dimensions.font20(context),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
