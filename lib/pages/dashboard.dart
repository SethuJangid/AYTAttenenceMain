import 'dart:async';
import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/chat2/Chating2.dart';
import 'package:AYT_Attendence/Screens/chat2/auth2.dart';
import 'package:AYT_Attendence/Screens/chat2/database.dart';
import 'package:AYT_Attendence/Screens/chat2/helperfunctions2.dart';
import 'package:AYT_Attendence/pages/EaelyCheck_IN_OUT.dart';
import 'package:AYT_Attendence/sidebar/image_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'birthdayFeed.dart';
import 'checkIN_OUT.dart';
import 'leaveFeed.dart';
import 'newsFeeds.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {

  String path=All_API().baseurl_img+All_API().profile_img_path;
  String name;
  String date;
  String uniqID;
  String latitude;
  String longitude;
  String action;
  String address;
  String device;
  String action_check;

  String workingHour;
  String accuuracy;

  String accuuracyPer;
  String accuuracy_meter;
  String statuscode;
  String s1;
  String s2;

  String email;
  String password;
  String uniqId;
  String userphn;
  String userimg;

  AuthService2 authService = new AuthService2();
  DatabaseMethods2 databaseMethods = new DatabaseMethods2();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();

  bool showSignIn = true ;
  var onErrorFirebase;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    showData();
  }
  getData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    QuerySnapshot userInfoSnapshot = await DatabaseMethods2().getUserInfo(email);
    print(""+userInfoSnapshot.documents[0].data()["userEmail"]);
    var user = userInfoSnapshot.documents[0].data()["userEmail"];
    /*for(int i=0;userInfoSnapshot.size>0;i++){

      print("Firebase UID---->"+user);
    }*/

    setState(() {
      showSignIn=sharedPreferences.getBool('loggedIn');
      name=sharedPreferences.getString("name");
      uniqID=sharedPreferences.getString("unique_id");
      latitude=sharedPreferences.getString("lat");
      longitude=sharedPreferences.getString("long");
      action=sharedPreferences.getString("");
      address=sharedPreferences.getString("address");
      device=sharedPreferences.getString("device_id");

      userphn = sharedPreferences.getString("phone");
      userimg = sharedPreferences.getString("image");
      email = sharedPreferences.getString("email");
      password = sharedPreferences.getString("password");
      String image=path+userimg;
      if(user == email){
        signIn();
      }else{
        singUp(image);
      }


    });
  }
  signIn() async {
      await authService
          .signInWithEmailAndPassword(
          email, password)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot =
          await DatabaseMethods2().getUserInfo(email);
          HelperFunctions2.saveUserLoggedInSharedPreference(true);
          HelperFunctions2.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data()["userName"]);
          HelperFunctions2.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data()["userEmail"]);
          /*Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));*/
        } else {
          setState(() {
            //isLoading = false;
            //show snackbar
          });
        }
      });
  }

  singUp(String image) async {
    try{
      await authService.signUpWithEmailAndPassword(email,password)
          .then((result){
        if(result != null){
          Map<String,String> userDataMap = {

            "userName" : name,
            "userEmail" : email,
            "userImage" : image,
          };
          print("Result---->"+result.toString());
          databaseMethods.addUserInfo(userDataMap);
          HelperFunctions2.saveUserLoggedInSharedPreference(true);
          HelperFunctions2.saveUserNameSharedPreference(name);
          HelperFunctions2.saveUserEmailSharedPreference(email);
          HelperFunctions2.saveUserImageSharedPreference(image);
          /*Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));*/
        }
      });
    }catch(signUpError){
      print("SignUP Error!!!!!!!!!!--->"+signUpError.code);
      if(signUpError is PlatformException) {
        if(signUpError.code == '[firebase_auth/email-already-in-use] The email address is already in use by another account') {
          signIn();
        }
      }
    }

  }

  showData(){
    trackdashStudent(uniqID,device);
  }

  @override
  Widget build(BuildContext context) {
    var duration=new Duration(seconds: 1);
    // Timer(duration, showData);
    setState(() {
      s1= accuuracy_meter!=null?"Your current location is accurate to "+accuuracy_meter:'';
      s2= accuuracyPer!=null?" ,\nGPS accuracy level "+accuuracyPer:'';
    });

    return Scaffold(
        body: Container(
          child: new Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(0),
                child: ImageSlider(),
              ),
              new Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Center(

                  child: Text(name!=null?"Welcome "+name:"ADIYOGI",
                    style: TextStyle(
                        fontSize: 20, fontStyle: FontStyle.normal,
                        color: Colors.black),),
                ),
              ),
              new Expanded(
                flex: 1,
                child:RefreshIndicator(
                  onRefresh: _refreshLocalGallery,
                  child: new SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [

                        Container(
                          child: SizedBox(
                            height: 150,
                            child: new EaelyCheck_IN_OUT(),
                          ),
                        ),
                        Container(
                            child: SizedBox(
                              height: 120,
                              child: new leaveFeed(unique_id: uniqID,),
                            ),

                        ),
                        Container(
                          child: SizedBox(
                            height: 150,
                            child: checkIN_OUT(),
                          ),
                        ),
                        Card(
                          color:Colors.orange[100],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(s1+s2==null?'Your current location is accurate to\nGPS accuracy level':s1+s2,style: TextStyle(fontSize:18,color: Colors.blue[1000]),),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 240,
                            child: birthdayFeed()),
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                            height: 160,
                            child: newsFeeds()),

                      ],

                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
  Future<Null> _refreshLocalGallery() async{
    print('refreshing stocks...');
  }
  Future trackdashStudent(String unique_id,String device_id) async {
    var endpointUrl = All_API().baseurl+All_API().api_tack_dashboard +unique_id+"/"+device_id;
    // var endpointUrl = All_API().baseurl+All_API().api_tack_dashboard +"NODK2J2S0N5Z5M8C5P3T4X"+"/"+"046b75822227087b";
    print("URL dash-->"+endpointUrl);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    Map<String, String>  queryParameter={
      'latitute':latitude,
      'longitute':longitude,
    };
    // Map<String, String>  queryParameter={
    //   'latitute':'26.2977743',
    //   'longitute':'73.0395951',
    // };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print("URLBody_dash-->"+requestUrl);
    var response = await http.get(requestUrl,headers: headers);
    statuscode=response.statusCode.toString();
    if(response.statusCode==200){
      setState(() {
        Map jasonData = jsonDecode(response.body);
        workingHour=jasonData['data'][0]['workRecord'][0]['difference_time'];
        accuuracyPer=jasonData['data'][0]['locationRecord'][0]['accuracy_per'];
        accuuracy_meter=jasonData['data'][0]['locationRecord'][0]['accuracy_meter'];
        print('Dassboard : '+jasonData.toString());
        print('DassboardData : '+workingHour+" "+accuuracyPer+" "+accuuracy_meter);
      });

    }else{
      final snackBar = SnackBar(content: Text('!Error..Not Fetch Lat Long',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
