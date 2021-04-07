import 'package:AYT_Attendence/Screens/chat2/CustomDialogBox.dart';
import 'package:AYT_Attendence/Screens/chat2/widget.dart';
import 'package:AYT_Attendence/Screens/chat2/constants.dart';
import 'package:AYT_Attendence/Screens/chat2/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chat2 extends StatefulWidget {
  final String chatRoomId;
  final String userName;
  final String userImage;

  Chat2({
    this.chatRoomId,
    this.userName,
    this.userImage,
  });

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat2> {

  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages(){
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              print("Message-->"+snapshot.data.documents[index].data()["message"]);
              print("Name-->"+snapshot.data.documents[index].data()["sendBy"]);
              return MessageTile(
                message: snapshot.data.documents[index].data()["message"],
                sendByMe: Constants2.myName == snapshot.data.documents[index].data()["sendBy"],
                time: snapshot.data.documents[index].data()["time"],
              );
            }) : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants2.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().toIso8601String(),
      };

      DatabaseMethods2().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  int currentTime;

  @override
  void initState() {
    DatabaseMethods2().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.blue[1000],
        title: Text(widget.userName,style: TextStyle(fontSize: 20,color: Colors.orange),),
        elevation: 0.0,
        leading: GestureDetector(
          onTap: (){
            showDialog(context: context,
                builder: (BuildContext context){
                  return CustomDialogBox(title: widget.userName,img: widget.userImage,);
                }
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                widget.userImage,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      /*body: Stack(
        children: [
          chatMessages(),
          SizedBox(height: 150,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0,bottom: 5,left: 5,right:10 ),
                      child: TextField(
                        cursorColor: Colors.blue[1000],
                        controller: messageEditingController,
                        style: simpleTextStyle(),
                        decoration: InputDecoration(
                            hintText: "Message ...",
                            hintStyle: TextStyle(
                              color: Colors.orange,
                              fontSize: 16,
                            ),
                          fillColor: Colors.blue[1000],
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    )
                ),
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    color: Colors.blue[1000]
                  ),
                  child: GestureDetector(
                    onTap: () {
                      addMessage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),*/
      body: StreamBuilder(
        stream: chats,
        builder: (context, snapshot){
          return snapshot.hasData ?  ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                print("Message-->"+snapshot.data.documents[index].data()["message"]);
                print("Name-->"+snapshot.data.documents[index].data()["sendBy"]);
                return MessageTile(
                  message: snapshot.data.documents[index].data()["message"],
                  sendByMe: Constants2.myName == snapshot.data.documents[index].data()["sendBy"],
                  time: snapshot.data.documents[index].data()["time"],
                );
              }) : Container();
        },
      ),
      persistentFooterButtons: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0,bottom: 5,left: 5,right:10 ),
                    child: TextField(
                      cursorColor: Colors.blue[1000],
                      controller: messageEditingController,
                      style: simpleTextStyle(),
                      decoration: InputDecoration(
                        hintText: "Message ...",
                        hintStyle: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                        ),
                        fillColor: Colors.blue[1000],
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    color: Colors.blue[1000]
                ),
                child: GestureDetector(
                  onTap: () {
                    addMessage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

class MessageTile extends StatelessWidget {
  final String message;
  String time;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe,@required this.time});


  @override
  Widget build(BuildContext context) {
    var splitTime = time.split("T");
    var sDate = splitTime[0];
    var sTime = splitTime[1];
    var sTimeSplite = sTime.split(".");
    time = sTimeSplite[0].trim();
    var hour = time.split(":")[0];
    var minute = time.split(":")[1];
    time = hour +":"+minute;
    print(splitTime);
    print(sDate);
    print(sTime);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: sendByMe ? 0 : 24,
              right: sendByMe ? 24 : 0),
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
                margin: sendByMe
                    ? EdgeInsets.only(left: 30)
                    : EdgeInsets.only(right: 30),
                padding: EdgeInsets.only(
                    top: 17, bottom: 17, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: sendByMe ? BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomLeft: Radius.circular(23)
                    ) :
                    BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomRight: Radius.circular(23)),
                    gradient: LinearGradient(
                      colors: sendByMe ? [
                        const Color(0xff0e46ac),
                        const Color(0xff001741)
                      ]
                          : [
                        const Color(0xffee8d02),
                        const Color(0xffd59d4d)
                      ],
                    )
                ),
                child: Text(message,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)
                ),
              ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 0, bottom: 0, left: 20, right: 20),
          child: Container(
            alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(time,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 10,
                    fontWeight: FontWeight.w300)
            ),
          ),
        ),
      ],
    );
  }
}