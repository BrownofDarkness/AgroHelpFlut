import 'dart:convert';

import 'package:agrohelp/data/controllers/forum_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../base/show_custom_snackBar.dart';
import '../../data/controllers/auth_controller.dart';
import '../../utils/dimentions.dart';
import '../../widgets/comment_item.dart';
import '../../widgets/replie_item.dart';

class CommentReplies extends StatefulWidget {
  final int forum;
  final int comment;
  const CommentReplies({super.key,required this.forum, required this.comment});

  @override
  State<CommentReplies> createState() => _CommentRepliesState();
}

class _CommentRepliesState extends State<CommentReplies> { 

  TextEditingController controller  = TextEditingController();
  WebSocketChannel? channel;

  void initSocket() {
      // Spécifier l'URL du serveur WebSocket
      String userToken = Get.find<AuthController>().userToken;
      int forumId = Get.find<ForumController>().getForumId(widget.forum);
      String url = 'ws://localhost:8000/ws/forum_chat/$forumId/?token=$userToken';

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
        if (jsonMap['message']['msg_type'] == "comment_created"){
          Get.find<ForumController>().addNewForumComment(jsonMap['message']['data']);
          print(jsonMap['message']['data']);
        }

      }, onDone: () {
        print('WebSocket connection closed');
      });
    }

    void createForumComent(int parent) {
      String content = controller.text.trim();
      if(content.isEmpty){
        ShowCustomSnackBar("type in your comment", title: "Forum Comment");
      }else{
        int forumId = Get.find<ForumController>().getForumId(widget.forum);
        // Créez un objet JSON
        Map<String, dynamic> messageData = {
          "message": {
            "data": {
              "content": content,
              "forum": forumId,
              "parent": parent,
            }
          },
        };
        // Convertissez l'objet JSON en une chaîne JSON
        String messageString = jsonEncode(messageData);

        // Envoyez le message au serveur
        channel?.sink.add(messageString);
      }
    }

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  @override
  void dispose() {
    controller.dispose();
    channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForumController>(builder: (forumcontroller){
        return Scaffold(
          body: Container(
            child: Column(
              children: [
                SizedBox(height: Dimensions.height20(context),),
                Row(
                    children: [
                      IconButton(
                        onPressed:  (){
                            Get.back();
                        }, 
                        icon: Icon(Icons.arrow_circle_left_outlined , size: Dimensions.height30(context), color: Color.fromARGB(255, 44, 131, 231),),
                      ),
                      Expanded(child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Réponses",
                            style: TextStyle(
                            fontFamily: 'Chakra_Petch',
                            fontSize: Dimensions.height20(context),
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      )),
                    ],
                ),
                SizedBox(height: Dimensions.height10(context),),
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height10(context)*0.3,
                  color:Color.fromARGB(255, 231, 230, 230),
                  child: Text(" "),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          CommentItem(comment:forumcontroller.forums[widget.forum].comments[widget.comment]),
                          SizedBox(height: Dimensions.height10(context),),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: Dimensions.width30(context)*2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20(context)*0.5)),
                                    color: Color.fromARGB(255, 248, 247, 247)                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: Dimensions.width20(context),),
                            
                                      Icon(Icons.insert_comment, size: Dimensions.height20(context)*1.2,color: Color.fromARGB(255, 15, 92, 17),),
                                      SizedBox(width: Dimensions.width20(context)*0.25,),
                                      Text(
                                        forumcontroller.forums[widget.forum].comments[widget.comment].replies.length.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Chakra_Petch',
                                          fontSize: Dimensions.height15(context),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ),
                          SizedBox(height: Dimensions.height10(context),),
                          for (int j=0; j<forumcontroller.forums[widget.forum].comments[widget.comment].replies!.length; j++)...[
                            ReplieItem(replie: forumcontroller.forums[widget.forum].comments[widget.comment].replies[j],),
                            SizedBox(height: Dimensions.height10(context),),
                          ]
                        ]
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
            color: Color.fromARGB(255, 203, 213, 224),
            ),
            child: Row(
              children: [
                SizedBox(width: Dimensions.height10(context)*0.5,),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: Dimensions.height20(context)*3,
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    onSubmitted: (String value) {
                      controller.text += '\n';
                    },
                    cursorColor: Color(0xFF025592),
                    style: TextStyle(
                      fontFamily: 'Chakra_Petch',
                      fontSize: Dimensions.height15(context),
                      fontWeight: FontWeight.w600
                    ),
                    decoration:   InputDecoration(
                      contentPadding: EdgeInsets.only(top: Dimensions.height10(context)*0.5, left: Dimensions.height10(context)*0.8),
                      hintText: "make a replie",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius20(context))*0.6,
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 44, 131, 231),
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.6),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Color.fromARGB(255, 44, 131, 231),
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius20(context)*0.6),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Color.fromARGB(255, 44, 131, 231),
                        )
                      ),
                    ),
                  )
                )
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      print(controller.text);
                      createForumComent(forumcontroller.forums[widget.forum].comments[widget.comment].id);
                      controller.clear();
                    },
                    icon: Icon(Icons.send),
                    iconSize: Dimensions.height20(context),
                    color: Color(0xFF025592),
                  )
                  ),
              ],
            ),
            
          ),
        );
      });
  }
}