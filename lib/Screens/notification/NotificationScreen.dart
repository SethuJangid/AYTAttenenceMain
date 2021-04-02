import 'dart:convert';
import 'dart:io';

import 'package:AYT_Attendence/API/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'NotificationModel.dart';

class NotificationScreen extends StatefulWidget {
  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  String name;
  String uniqId ;
  String user_unique_id ;
  String email ;
  String phone ;
  String dob ;
  String joining_date ;
  String department_id ;
  String designation_id ;
  String image ;
  File uploadimage;
  var StatusCode;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<NotificationModel> notification() async {
    var endpointUrl =
        All_API().baseurl + All_API().api_notification + uniqId;
    print("NotificationUrl--> " + endpointUrl);
    try {
      var response = await http.get(endpointUrl, headers: {
        All_API().key: All_API().keyvalue,
      });
      var jasonDataNotification = jsonDecode(response.body);
      var msg=jasonDataNotification['msg'];
      StatusCode=response.statusCode;
      print("Notificationresponse--> " + response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return NotificationModel.fromJson(jasonDataNotification);

      }else{
        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
    } catch (Exception) {
      return Exception;
    }
  }
  getData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      name=sharedPreferences.getString("name");
      uniqId=sharedPreferences.getString("unique_id");
      user_unique_id=sharedPreferences.getString("user_unique_id");
      email=sharedPreferences.getString("email");
      phone=sharedPreferences.getString("phone");
      dob=sharedPreferences.getString("dob");
      joining_date=sharedPreferences.getString("joining_date");
      department_id=sharedPreferences.getString("department_id");
      designation_id=sharedPreferences.getString("designation_id");
      image=sharedPreferences.getString("image");
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[1000],
          title: Container(
            margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
            child: Text(
              'Notification', style: TextStyle(color: Colors.orange),),
          ),
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),),
        body: FutureBuilder<NotificationModel>(
            future: notification(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var notificationlist = snapshot.data.data[index];
                      var str=notificationlist.date.toString();
                      var Strdate=str.split(" ");
                      var date = Strdate[0].trim();
                      var time = Strdate[1].trim();
                      print("notificationlist-->"+notificationlist.title);
                      return Card(
                        elevation: 8.0,
                        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.blue[1000],
                            borderRadius: BorderRadius.all(Radius.circular(10.0)
                              // topRight: Radius.circular(10.0),
                              // bottomRight: Radius.circular(10.0),
                              // topLeft: Radius.circular(10.0),
                              // bottomLeft: Radius.circular(10.0),
                            ),
                          ),

                          margin:const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 5),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

                            title: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                notificationlist.title,
                                style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                            subtitle: Column(
                              children: <Widget>[
                                Text(notificationlist.message,textDirection: TextDirection.ltr,
                                  style: TextStyle(color:Colors.white),softWrap: true,),
                                SizedBox(
                                  height: 20,
                                  width: 10,
                                ),
                                Text.rich(

                                  TextSpan(
                                    style: TextStyle(
                                        fontSize: 17, color:Colors.amber
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '$date',
                                      ),
                                      WidgetSpan(
                                        child: Icon(Icons.arrow_right_sharp,color: Colors.white),
                                      ),
                                      TextSpan(
                                        text: '$time',
                                      )
                                    ],
                                  ),
                                )

                              ],
                            ),
                            // trailing:
                            //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),

                          ),
                        ),
                      );

                    });
              }
              else if(snapshot.hasData == false){

                return Center(
                  child: Card(
                    color: Colors.blue[1000],
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(All_API().two_error_occurred,style: TextStyle(fontSize: 15,color: Colors.orange,),textAlign: TextAlign.center,),
                    ),
                  ),
                );

              }else
                return StatusCode==400?Center(
                  child: Card(
                    color: Colors.blue[1000],
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(All_API().four_error_occurred,style: TextStyle(fontSize: 15,color: Colors.orange,),textAlign: TextAlign.center,),
                    ),
                  ),
                ):
                CircularProgressIndicator();
            }),
      ),
    );
  }
}


