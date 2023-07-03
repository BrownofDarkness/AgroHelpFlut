import 'dart:convert';

import 'package:agrohelp/data/controllers/auth_controller.dart';
import 'package:agrohelp/pages/drawer/Drawer_page.dart';
import 'package:agrohelp/utils/app_constants.dart';
import 'package:agrohelp/utils/dimentions.dart';
import 'package:agrohelp/widgets/forum_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../base/show_custom_snackBar.dart';
import '../../data/controllers/culture_controller.dart';
import '../../data/controllers/forum_controller.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  var question = TextEditingController();
  WebSocketChannel? channel;

  Future<void> _loadressource() async {
    await Get.find<ForumController>().getQuestions();
  }

  String tronk(text, textHeight) {
    String firstHalf;
    if (text.length > textHeight) {
      firstHalf = text.substring(0, textHeight.toInt()) + " .....";
    } else {
      firstHalf = text;
    }
    return firstHalf;
  }

  void _createForum(ForumController forumController) {
    String content = question.text.trim();
    if (content.isEmpty) {
      ShowCustomSnackBar("type in your question", title: "Forum question");
    } else {
      ShowCustomSnackBar("All went well", title: "Perfect");

      print(content);
      forumController.createForum(content).then((status) {
        if (status.isSucess == true) {
          ShowCustomSnackBar("user was successfully logged in ",
              title: "sing in", isError: false);
        } else {
          ShowCustomSnackBar(
            status.message,
          );
        }
      });
    }
  }

  void initSocket() {
    // Spécifier l'URL du serveur WebSocket
    String userToken = Get.find<AuthController>().userToken;
    String url = '${AppConstants.WS_URL}/ws/public_forum/?token=$userToken';

    // Créer une instance de SocketIO
    channel = IOWebSocketChannel.connect(url);

    // Écouter l'événement de connexion réussie
    if (channel?.closeCode == null) {
      // La connexion est établie
      print('WebSocket connection is open');
    }

    channel?.stream.listen((dynamic message) {
      dynamic jsonData = jsonDecode(message);
      Map<String, dynamic> jsonMap = jsonData as Map<String, dynamic>;
      if (jsonMap['message']['msg_type'] == "forum_created") {
        Get.find<ForumController>().addNewForum(jsonMap['message']['data']);
        print(jsonMap['message']['data']);
      }

      if (jsonMap['message']['msg_type'] == "forum_commented") {
        Get.find<ForumController>()
            .addNewForumComment(jsonMap['message']['data']);
        print(jsonMap['message']['data']);
      }
    }, onDone: () {
      print('WebSocket connection closed');
    });
  }

  @override
  void initState() {
    super.initState();
    initSocket();
    _loadressource();
  }

  @override
  void dispose() {
    question.dispose();
    channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF025592),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white54,
                  size: Dimensions.height30(context),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Ouvre le drawer
                },
              );
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Forum Page",
                    style: TextStyle(
                      fontFamily: 'Chakra_Petch',
                      color: Colors.white60,
                      fontSize: Dimensions.height20(context),
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: Dimensions.width30(context) * 3,
                child: IconButton(
                  onPressed: () {
                    print("dialog");
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white54,
                    size: Dimensions.height30(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: DrawerPage(),
        body: GetBuilder<ForumController>(builder: (forumcontroller) {
          return Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20(context) * 1.5,
                right: Dimensions.width20(context) * 1.5,
                top: Dimensions.height20(context)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  height: Dimensions.height30(context) * 2,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              child: TextField(
                        maxLines: null,
                        onSubmitted: (String value) {
                          question.text += '\n';
                        },
                        cursorColor: Color.fromARGB(255, 44, 131, 231),
                        style: TextStyle(
                            fontFamily: 'Chakra_Petch',
                            fontSize: Dimensions.height15(context),
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          hintText: "Ask a Question",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                      Dimensions.radius20(context)) *
                                  0.5,
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.grey,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius20(context) * 0.5),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.grey,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius20(context) * 0.5),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.grey,
                              )),
                        ),
                        controller: question,
                      ))),
                      SizedBox(width: Dimensions.width10(context)),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            print("lancer la rechrche");
                            _createForum(forumcontroller);
                            question.clear();
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: 'Chakra_Petch',
                              color: Colors.white,
                              fontSize: Dimensions.font16(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 44, 131, 231),
                            minimumSize: Size(Dimensions.width20(context) * 0.7,
                                Dimensions.height30(context) * 1.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height30(context),
                ),
                GetBuilder<CultureController>(builder: (cultures) {
                  return Expanded(
                      child: SingleChildScrollView(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: forumcontroller.forums.length,
                        itemBuilder: (context, index) {
                          return ForumItem(
                            question: forumcontroller.forums[index],
                            index: index,
                          );
                        }),
                  ));
                }),
              ],
            ),
          );
        }));
  }
}
