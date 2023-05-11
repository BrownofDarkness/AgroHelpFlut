import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:agrohelp/pages/auth/sing_up_page.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackBar.dart';
import '../../data/controllers/auth_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimentions.dart';

import '../../utils/colors.dart';

import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    void _login(AuthController authController){
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      if(email.isEmpty){
        ShowCustomSnackBar("type in your email adress", title: "Email adress");
      }else if(!GetUtils.isEmail(email)){
        ShowCustomSnackBar("type in a valid email adress", title: "Email adress");
      }else if(password.isEmpty){
        ShowCustomSnackBar("type in your password", title: "Password");
      }else if(password.length<6){
        ShowCustomSnackBar("password can not be less than six characters", title: "Password");
      }else{
        ShowCustomSnackBar("All went well", title: "Perfect");
        authController.login(email, password).then((status) {
          if(status.isSucess==true){
            print("Success login");
          }else{
            ShowCustomSnackBar(status.message,);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authcontroller){
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height20(context)*2,),
              //app logo
              Container(
                height: Dimensions.screenHeight(context)*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius30(context)*2.7,
                    backgroundImage: AssetImage(
                        "assets/images/agrologo.png"
                    ),
                  ),
                ),
              ),
              // welcome
              Text(
                "Login",
                style: TextStyle(
                  fontSize: Dimensions.font20(context)*1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Dimensions.height20(context)*2,),
              // your email
              AppTextField(
                textController: emailController,
                hintText: "Email",
                icon: Icons.alternate_email_rounded,
              ),
              SizedBox(height: Dimensions.screenHeight(context)*0.05,),
              // your password
              AppTextField(
                textController: passwordController,
                hintText: "Password",
                icon: Icons.lock_outlined,
                isObscur: true,
              ),

              SizedBox(height: Dimensions.screenHeight(context)*0.08,),
              GestureDetector(
                onTap: (){
                  _login(authcontroller);
                },
                child: Container(
                  width: Dimensions.screenWidth(context)/1.5,
                  height: Dimensions.screenHeight(context)/15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                    color: Color(0xFF025592),
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sing In",
                      size: Dimensions.font20(context)*1.3,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight(context)*0.03,),
              SizedBox(height: Dimensions.screenHeight(context)*0.03,),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.toNamed(RouteHelper.getRegister()),
                  text: "Forgot Password?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20(context),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight(context)*0.03,),
              RichText(
                text: TextSpan(
                  text: "Don\'t have an account?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20(context),
                  ),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SingUpPage(), transition: Transition.fade),
                        text: "Create",
                        style: TextStyle(
                            color: Appcolors.mainBlackColor,
                            fontSize: Dimensions.font20(context),
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },)
    );
  }
}
