import 'package:AYT_Attendence/Screens/chat2/constants.dart';
import 'package:AYT_Attendence/Screens/chat2/helperfunctions2.dart';
import 'package:AYT_Attendence/Screens/chat2/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Chat.dart';
import 'database.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  DatabaseMethods2 databaseMethods = new DatabaseMethods2();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;
  String userImage;

  initiateSearch() async {
    userImage = await HelperFunctions2.getUserImageSharedPreference();
    if(searchEditingController.text.isNotEmpty){
      setState(() {
        isLoading = true;
      });
      await databaseMethods.searchByName(searchEditingController.text)
          .then((snapshot){
        searchResultSnapshot = snapshot;
        print("Search Name-->$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList(){
    return haveUserSearched ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchResultSnapshot.documents.length,
        itemBuilder: (context, index){
        print("UserNAme--->"+searchResultSnapshot.documents[index].data()["userName"]);
        print("UserEmail--->"+searchResultSnapshot.documents[index].data()["userEmail"]);
        return userTile(
          searchResultSnapshot.documents[index].data()["userName"],
          searchResultSnapshot.documents[index].data()["userEmail"],
        );
        }) : Container();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName){
    List<String> users = [Constants2.myName,userName];

    String chatRoomId = getChatRoomId(Constants2.myName,userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Chat2(
        chatRoomId: chatRoomId,
        userName: userName,
        userImage: userImage,
      )
    ));

  }

  Widget userTile(String userName,String userEmail){
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                  ),
                ),
                Text(
                  userEmail,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                  ),
                )
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                sendMessage(userName);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.blue[1000],
                    borderRadius: BorderRadius.circular(24)
                ),
                child: Text("Message",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16
                  ),),
              ),
            )
          ],
        ),
      ),
    );
  }


  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
    userList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[1000],
        title: Text(
          "SEARCH LIST",
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
      body: isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :  Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Color(0xFF5F5E5E),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      style: simpleTextStyle(),
                      decoration: InputDecoration(
                        hintText: "search username ...",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Icon(Icons.search,size: 25,),
                  )
                ],
              ),
            ),
            userList()
          ],
        ),
      ),
    );
  }
}


