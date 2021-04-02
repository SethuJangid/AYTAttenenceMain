import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/LoginScreen/login2.dart';
import 'package:AYT_Attendence/Widgets/pin_entry_text_field.dart';
import 'package:AYT_Attendence/model/MainProfileModel.dart';
import 'package:AYT_Attendence/pages/homepage.dart';
import 'package:AYT_Attendence/pages/myaccountspage.dart';
import 'package:AYT_Attendence/sidebar/bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  final String opt;
  final String phone;



  OTPScreen({this.opt,this.phone,});

  /*Future<MainProfileModel> loadUserData()async{
    String url = 'http://adiyogitechnosoft.com/attendance_dev/api2/employee/verify_otp';
    Map<String, String> headers = {'X-API-KEY': 'NODN2D0I7W4V8I2K'};
    String json = jsonEncode({"phone":phone,"otp": opt ,"fcm_id":fcmID});
    print(json);
    final http.Response response = await http.post(url,body:json);
    Map jasonData = jsonDecode(response.body);
    bool statusCode = jasonData['status'];
    print(statusCode);
    print(jasonData);
    if(statusCode==true){
      return new MainProfileModel.fromJson(jasonData);
    }else{

    }
  }*/

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String fcmID;

  getData()async {
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    setState(() {
      fcmID = sharedPreferences.getString("fcmID");
    });
  }

  List<MainProfileModel> list;
  FocusNode focusNode = new FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    print("OTP PAGE : "+widget.opt);
    var  CheckOTP=widget.opt;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: ListView(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 50.0),
                child: Image.asset('assets/ayt.png',color:Colors.white,width: 150,height: 150,
                  alignment: Alignment.topCenter,),
                alignment: Alignment.center,
                color: Colors.blue[1000],
                height: 300,
              ),
              Container(
                color: Colors.white,
                height: 600,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0, 0.0),
                        )],
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    transform: Matrix4.translationValues(0.0, -100.0, 0.0),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
                    child: ListView(
                      children: [
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Center(child:Container(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: Text(' Otp Verification ',
                                      style: TextStyle(fontSize: 30)))),
                              Center(child:Container(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: Text(widget.phone,
                                      style: TextStyle(fontSize: 22)))),
                              Center(child:Container(
                                width: 300,
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child:PinEntryTextField(
                                  showFieldAsBox: true,
                                  lastPin: widget.opt,
                                  onSubmit: (otp){
                                     CheckOTP=otp;
                                    print("pin view : "+otp+" "+widget.opt);
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            title: Text("Verification"),
                                            content: Text('Pin entered is ${widget.opt}'),
                                          );
                                        }
                                    ); //end showDialog()
                                  },
                                ),
                              )
                              ),
                              Center(child:
                              RaisedButton(
                                child: Text('VERIFY OTP'),
                                color: Colors.orange,
                                textColor: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blue[1000])
                                ),
                                padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                                splashColor: Colors.blue[1000],
                                onPressed: () {
                                  //onpressed gets called when the button is tapped.
                                  if(CheckOTP!=null && CheckOTP==widget.opt){
                                    print("CheckOTP-->"+CheckOTP);
                                    otpCheck(widget.opt,widget.phone,fcmID,context);

                                  }else{
                                    FocusScope.of(context).requestFocus(focusNode);
                                    final snackBar = SnackBar(content: Text('Your OTP is not Correct',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
                                    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                              ),
                              ),
                              // Center(
                              //   child:FlatButton(
                              //     onPressed: () {
                              //       //Navigator.pushNamed(context, "YourRoute");
                              //       resendOTP(widget.phone);
                              //     },
                              //     child: new Text("Resend OTP"),
                              //   ),)
                            ]
                        ),
                      ]
                    )
                ),
              ),]
        ),
      ),
    );
  }

  Future<MainProfileModel> otpCheck(String opt1, String phone1,String fcmid,BuildContext buildContext) async {
    String url = All_API().baseurl +All_API().api_otp_verify;

    String body = jsonEncode({"phone": phone1,"otp":opt1 ,"fcm_id":fcmID });
    print("phone_body--> " + body);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var response = await http.post(url,body:body,headers: headers);
    Map jasonData = jsonDecode(response.body);
    // bool statusCode = jasonData['status'];

    print("OTPstatusCode-->"+response.statusCode.toString());
    print("OTPresponse->"+jasonData.toString());

    if(response.statusCode == 200){
      FocusScope.of(context).requestFocus(focusNode);
      final snackBar = SnackBar(content: Text('Your Are Sucessfully Register',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
      var name = jasonData['data'][0]['name'];
      var uniqId = jasonData['data'][0]['unique_id'];
      var useruniqId = jasonData['data'][0]['user_unique_id'];
      var email = jasonData['data'][0]['email'];
      var phone = jasonData['data'][0]['phone'];
      var password = jasonData['data'][0]['password'];
      var dob = jasonData['data'][0]['dob'];
      var joining_date = jasonData['data'][0]['joining_date'];
      var department_id = jasonData['data'][0]['department_id'];
      var designation_id = jasonData['data'][0]['designation_id'];
      var device_id = jasonData['data'][0]['device_id'];
      var image = jasonData['data'][0]['image'];
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString("name", name);
      sharedPreferences.setString("unique_id", uniqId);
      sharedPreferences.setString("user_unique_id", useruniqId);
      sharedPreferences.setString("email", email);
      sharedPreferences.setString("phone", phone);
      sharedPreferences.setString("password", password);
      sharedPreferences.setString("dob", dob);
      sharedPreferences.setString("joining_date", joining_date);
      sharedPreferences.setString("department_id", department_id);
      sharedPreferences.setString("designation_id", designation_id);
      sharedPreferences.setString("image", image);
      sharedPreferences.setString("device_id", device_id);
      if(uniqId.toString().isNotEmpty){
        sharedPreferences.setBool("loggedIn", true);
      }

      print(name+"-----"+uniqId+"--------"+useruniqId);
      Navigator.pushReplacement(buildContext, MaterialPageRoute(builder: (context) => BottomNavBar()));
      return MainProfileModel.fromJson(jasonData);

    }else{
      FocusScope.of(context).requestFocus(focusNode);
      final snackBar = SnackBar(content: Text('Your OTP is Not Correct',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement(buildContext, MaterialPageRoute(builder: (context) => MyLogin2()));
    }
  }

  void resendOTP(String phnno)async {
    String url = 'http://adiyogitechnosoft.com/attendance_dev/api/login';
    // Map<String, String> headers = {'X-API-KEY': 'NODN2D0I7W4V8I2K'};
    String json = jsonEncode({"phone": phnno});
    // make POST request
    final http.Response response = await http.post(url, body: json);
    int statusCode = response.statusCode;
    if (response.statusCode == 200) {
      Map jasonData = jsonDecode(response.body);

    } else {

    }
  }
}