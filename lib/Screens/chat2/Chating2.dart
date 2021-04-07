import 'package:AYT_Attendence/Screens/chat2/constants.dart';
import 'package:AYT_Attendence/Screens/chat2/search.dart';
import 'package:AYT_Attendence/Screens/chat2/theme.dart';
import 'package:flutter/material.dart';

import 'Chat.dart';
import 'database.dart';
import 'helperfunctions2.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;
  String image;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatRoomsTile(
                userName: snapshot.data.documents[index].data()['chatRoomId']
                    .toString()
                    .replaceAll("_", "")
                    .replaceAll(Constants2.myName, ""),
                chatRoomId: snapshot.data.documents[index].data()["chatRoomId"],
                userImage: image==null?"https://icons-for-free.com/iconfiles/png/512/business+costume+male+man+office+user+icon-1320196264882354682.png":image,
              );
            })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants2.myName = await HelperFunctions2.getUserNameSharedPreference();
    image = await HelperFunctions2.getUserImageSharedPreference();
    DatabaseMethods2().getUserChats(Constants2.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants2.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[1000],
        title: Text(
          "AYT CHATS",
          style: TextStyle(fontSize: 20,color: Colors.orange),
        ),
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/ayt.png",
            height: 40,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search,color: Colors.orange,),
        backgroundColor: Colors.blue[1000],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final String userImage;

  ChatRoomsTile({this.userName,@required this.chatRoomId,this.userImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Chat2(
                chatRoomId: chatRoomId,
                userName: userName,
                userImage: userImage,
              )
          ));
        },
        child: Card(
          elevation: 8,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                /*Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      //color: CustomTheme2.colorAccent,
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.network(userImage,height: 50,width: 50, fit: BoxFit.fill,),
                  *//*child: Text(userName.substring(0, 1),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),*//*
                ),*/
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    userImage,
                    height: 50.0,
                    width: 50.0,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(userName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ),
    );
  }
}