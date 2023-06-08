import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackBar.dart';
import '../../data/controllers/auth_controller.dart';
import '../../model/signUp_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimentions.dart';


import '../../widgets/big_text.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var emailfocus = FocusNode();
  var namefocus = FocusNode();
  var passwordfocus = FocusNode();
  var type;
  String email = '',password = '',name = '';
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordController.dispose();
    emailfocus.dispose();
    namefocus.dispose();
    passwordfocus.dispose();
    type;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var singUpImage = [
      "twitter.png",
      "facebook.png",
      "google.png"
    ];

    String selectedOption = ""; //  =variable pour stocker la valeur sélectionnée

    List<String> options = ['agriculteur', 'Expert'];
    List<DropdownMenuItem<String>> dropdownOptions = options
        .map((String option) => DropdownMenuItem<String>(
      value: option,
      child: Text(option),
    ))
        .toList();// liste des options

    void _registration(AuthController authController ){
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      type = selectedOption;
      if(name.isEmpty){
        ShowCustomSnackBar("type in your username", title: "Username");
      }else if(email.isEmpty){
        ShowCustomSnackBar("type in your email adress", title: "Email adress");
      }else if(!GetUtils.isEmail(email)){
        print(email);
        ShowCustomSnackBar("type in a valid email adress", title: "Email adress");
      }else if(password.isEmpty){
        ShowCustomSnackBar("type in your password", title: "Password");
      }else if(password.length<6){
        ShowCustomSnackBar("password can not be less than six characters", title: "Password");
      }else if(type.isEmpty){
        ShowCustomSnackBar("the type is empty please choose one", title: "Type");
      }else{
        ShowCustomSnackBar("All  informations was typed", title: "Perfect", isError: false);
        SingUpModel signUpModel = SingUpModel(
            username: name,
            email: email,
            password: password,
            type: type
        );
        authController.registration(signUpModel).then((status) {
          if(status.isSucess==true){
            ShowCustomSnackBar("user was successfully registered", title: "Registration", isError: false);
          }else{
            ShowCustomSnackBar(status.message,);
            print(status.message);
          }
        });
        authController.hello();
      }
    }

    List<FocusNode> focusNodes = [
      namefocus,
      emailfocus,
      passwordfocus,
    ];

    List<bool> obscured = [
      false,
      false,
      true,
    ];

    List<String> hintTexts = [
      "Username",
      "Email",
      "Password",
    ];

    List<IconData> icons = [
      Icons.person_outline,
      Icons.alternate_email,
      Icons.lock_outlined,

    ];


    List<TextEditingController> textControllers = [
      nameController,
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
          margin: EdgeInsets.only(left: Dimensions.height20(context)*2, right: Dimensions.height20(context)*2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.5),
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
              ]
          ),
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
              prefixIcon: Icon(icons[i], color: Colors.black,),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius20(context))*0.5,
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.white,
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )
              ),
            ),
          ),
        ),
      );
      if (i < focusNodes.length - 1) {
        textFields.add(
          SizedBox(height: Dimensions.height20(context),), // Ajoutez le SizedBox entre les champs de texte
        );
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
              Text(
                "Create An Account",
                style: TextStyle(
                  fontSize: Dimensions.font20(context)*1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Dimensions.height20(context),),
              Column(
                children: textFields,
              ),
              SizedBox(height: Dimensions.height20(context),),
              // your phone number
              Container(
                margin: EdgeInsets.only(left: Dimensions.height20(context)*2, right: Dimensions.height20(context)*2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.5),
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
                    ]
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type of your account",
                    prefixIcon: Icon(Icons.threesixty, color: Colors.black,),
                  ),
                  dropdownColor: Colors.lightGreen,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: Dimensions.height30(context),
                  isExpanded: true,
                  items: dropdownOptions,
                  onChanged: (String? value) {
                    selectedOption = value.toString().isEmpty?selectedOption: value.toString();
                    type = selectedOption;
                    print(selectedOption);
                  },
                ),
              ),
              SizedBox(height: Dimensions.height20(context)*2.5,),
              GestureDetector(
                onTap: (){
                  _registration(authcontroller);
                },
                child: Container(
                  width: Dimensions.screenWidth(context)/1.3,
                  height: Dimensions.screenHeight(context)/18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30(context)),
                    color: Color(0xFF025592),
                  ),
                  child: Center(
                    child: BigText(
                      text: "Register",
                      size: Dimensions.font20(context),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10(context),),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.toNamed(RouteHelper.getLogin()),
                  text: "Have an account already?",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: Dimensions.font20(context),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight(context)*0.05,),
              /*RichText(
                text: TextSpan(
                  text: "Sing up using one of the following methods",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: Dimensions.font16(context),
                  ),
                ),
              ),*/
              /*Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30(context),
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                        "assets/images/${singUpImage[index]}"
                    ),
                  ),
                )),
              )*/
            ],
          ),
        );
      },),
    );
  }
}
