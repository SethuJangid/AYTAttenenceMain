import 'dart:async';
import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/pages/EaelyCheck_IN_OUT.dart';
import 'package:AYT_Attendence/sidebar/image_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    showData();
  }

  getData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
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

    });
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
    //String device_id='ASD852SD';
    print("UNIQ ID Dasboad--->"+uniqID);
    print("device ID Dasboad--->"+device);
    print("latitude ID Dasboad--->"+latitude);
    print("longitude ID Dasboad--->"+longitude);

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
