import 'dart:convert';
import 'dart:typed_data';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/model/TrackAttendanceModel.dart';
import 'package:AYT_Attendence/pages/democalender.dart';
import 'package:AYT_Attendence/sidebar/bottom.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TrackAttendance extends StatefulWidget {
  @override
  TrackAttendanceState createState() => TrackAttendanceState();
}

class TrackAttendanceState extends State<TrackAttendance> {
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
  String  dateforattendance;
  String  formattedDateString;

  var statuseCode;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getCurrentDate();

  }
  getCurrentDate()async{
    getData();
    String formatted = DateFormat("yyyy-MM").format(DateTime.now());
    formattedDateString=formatted;
    print("DateTime_Formate:--> "+formatted);

    setState(() {
      /*sharedPreferences.setString("dateCurrent", formatted);
      print("Today Date : "+sharedPreferences.getString("dateCurrent"));*/
    });
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
  DateTime currentDate = DateTime.now();
  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        var str = currentDate.toString();
        var Strdate = str.split(" ");
        dateforattendance = Strdate[0].trim();
        DateTime formatteddate = DateTime.parse(dateforattendance);
         formattedDateString = DateFormat("yyyy-MM").format(formatteddate);
        print("formattedDateString:--> "+formattedDateString);

      });
  }
  Future<TrackAttendanceModel> notification() async {

    print("dateforattendance:--> "+formattedDateString);
    var endpointUrl =
        All_API().baseurl + All_API().api_track_attendance + uniqId;
    //print("TrackAttendanceUrl--> " + endpointUrl);
    Map<String, String> queryParameter = {
      'month': formattedDateString,
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print("requestUrl--> " + requestUrl);
    try {
      var response = await http.get(requestUrl, headers: {
        All_API().key: All_API().keyvalue,
      });
      print("TrackAttendanceresponse--> " + response.body);
      print("TrackAttendancestatusCode--> " + response.statusCode.toString());
      var jasonDataNotification = jsonDecode(response.body);
      var msg =jasonDataNotification['msg'];
      statuseCode=response.statusCode;
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return TrackAttendanceModel.fromJson(jasonDataNotification);
      }else{
        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
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
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text(
            'Track Attendance', style: TextStyle(color: Colors.orange),),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[1000],
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.orange,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      'Choose Date',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight:FontWeight.bold),textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(child:
                    RaisedButton(
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined),

                        ],
                      ),
                      color: Colors.blue[1000],
                      textColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue[1000])
                      ),
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      splashColor: Colors.blue[2000],
                      onPressed: () {
                        //onpressed gets called when the button is tapped.
                        print("FlatButton tapped");
                         //Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                        _selectDateFrom(context);
                      },
                    ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: mediaQuery.size.width * 0.33,
                child: Column(
                  children: [
                    Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                            //right: new BorderSide(width: 2.0, color: Colors.orange),
                            //left: new BorderSide(width: 1.0, color: Colors.orange)
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Date",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight:FontWeight.bold),textAlign: TextAlign.center,),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                    ),
                    FutureBuilder<TrackAttendanceModel>(
                        future: notification(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                itemCount: snapshot.data.data.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index){
                                  var article = snapshot.data.data[index];
                                  var str=article.checkinTime.toString();
                                  var Strdate=str.split(" ");
                                  var date = Strdate[0].trim();
                                  var time = Strdate[1].trim();
                                  return Card(
                                    color: Colors.blue[1000],
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(date,style: TextStyle(fontSize: 15,color: Colors.orange,),textAlign: TextAlign.center,),
                                    ),
                                  );
                                }
                            );
                          }
                          else{
                            return Center(
                                child: statuseCode==400?Card(
                                  color: Colors.blue[1000],
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text("No Record Found!!",style: TextStyle(fontSize: 15,color: Colors.orange,),textAlign: TextAlign.center,),
                                  ),
                                ):
                                CircularProgressIndicator());
                          }
                        }
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.deepOrange,
              ),
              Container(
                width: mediaQuery.size.width * 0.33,
                child: Column(
                  children: [
                    Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                            //right: new BorderSide(width: 2.0, color: Colors.orange),
                            //left: new BorderSide(width: 1.0, color: Colors.orange)
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Check In",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                    ),
                    FutureBuilder<TrackAttendanceModel>(
                        future: notification(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                itemCount: snapshot.data.data.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index){
                                  var article = snapshot.data.data[index];
                                  var str=article.checkinTime.toString();
                                  var Strdate=str.split(" ");
                                  var date = Strdate[0].trim();
                                  var time = Strdate[1].trim();
                                  return Card(
                                    color: Colors.blue[1000],
                                    elevation: 10,
                                    child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(time,style: TextStyle(fontSize: 15,color: Colors.orange,),textAlign: TextAlign.center,),
                                          ),
                                        ]),
                                  );
                                }
                            );
                          }
                          else{
                            return Center(
                                child: statuseCode==400?Card(
                                  color: Colors.blue[1000],
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text("No Record Found!!",style: TextStyle(fontSize: 15,color: Colors.orange,),textAlign: TextAlign.center,),
                                  ),
                                ):
                                CircularProgressIndicator());
                          }
                        }
                    ),

                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.deepOrange,
              ),
              Container(
                width: mediaQuery.size.width * 0.33,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                            //right: new BorderSide(width: 2.0, color: Colors.orange),
                            //left: new BorderSide(width: 1.0, color: Colors.orange)
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Check Out",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                    ),
                    FutureBuilder<TrackAttendanceModel>(
                        future: notification(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                itemCount: snapshot.data.data.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index){
                                  var article = snapshot.data.data[index];
                                  var str=article.checkoutTime.toString();
                                  if(article.checkoutTime=="Pending"){
                                    var checkout=article.checkoutTime;
                                    return Card(
                                      color: Colors.blue[1000],
                                      elevation: 10,
                                      child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(checkout,style: TextStyle(fontSize: 15,color: Colors.orange,),textAlign: TextAlign.center,),
                                            ),
                                          ]),
                                    );
                                  }else{
                                    var str=article.checkoutTime;
                                    var Strdate=str.split(" ");
                                    var date = Strdate[0].trim();
                                    var time = Strdate[1].trim();
                                    print(Strdate);
                                    return Card(
                                      color: Colors.blue[1000],
                                      elevation: 10,
                                      child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(time,style: TextStyle(fontSize: 15,color: Colors.orange,),textAlign: TextAlign.center,),
                                            ),
                                          ]),
                                    );
                                  }
                                }
                            );
                          }
                          else{
                            return Center(
                                child: statuseCode==400?Card(
                                  color: Colors.blue[1000],
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text("No Record Found!!",style: TextStyle(fontSize: 15,color: Colors.orange,),textAlign: TextAlign.center,),
                                  ),
                                ):
                                CircularProgressIndicator());
                          }
                        }
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}