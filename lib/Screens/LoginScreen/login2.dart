import 'dart:convert';
import 'dart:io';
import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/OtpVerificationScreen/otp_screen2.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter',
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            //title: Text('Flutter'),
          ),
          body: MyLogin2()),
    );
  }
}

class MyLogin2 extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin2> {
  TextEditingController _textEditingController = TextEditingController();
  String phnno;
  String getOTP;
  String fcmID;
  String deviceId;
  String inputNum;
  FocusNode focusNode = new FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    getDevice();
    super.initState();

  }
  getDevice()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    deviceId = await _getId();
    setState(() {
      sharedPreferences.setString("device", deviceId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: ListView(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 50.0),
                child: Image.asset('assets/ayt.png',color: Colors.white,width: 150,height: 150,
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
                                  child: Text(' Login ',
                                      style: TextStyle(fontSize: 30)))),
                              Center(child:Container(
                                width: 300,
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child:TextField(
                                  controller: _textEditingController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Mobile Number',
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                  //keyboardType: TextInputType.text,
                                  onChanged: (name) {
                                    this.phnno=name;

                                  },
                                ),
                              )
                              ),
                              Center(child:
                              RaisedButton(
                                child: Text('LOGIN'),
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
                                  if(_textEditingController.text.isNotEmpty&&_textEditingController.text.length==10){
                                    phnno =_textEditingController.text;
                                    // phnno ="8852911910";
                                    logg(phnno);
                                    print(phnno);
                                  }
                                  else{
                                    FocusScope.of(context).requestFocus(focusNode);
                                    final snackBar = SnackBar(content: Text('Field Required Or Mobile No is Not Correct',
                                      style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.orange,);


                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }

                                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OTPScreen()));
                                },
                              ),
                              ),
                            ]
                        ),
                      ],
                    )
                ),
              ),]
        ),
      ),
    );
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  void logg(String phnno) async {
    String url = All_API().baseurl +All_API().api_login;
    print("response_url--> " +  url);
    String body =jsonEncode({"phone":phnno, "device_id": deviceId});
    print("phone_body--> " + body);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };

    var response = await http.post(url,body:body,headers: headers);
    print("response--> " +  response.toString());
    // check the status code for the result
    int statusCode = response.statusCode;
    print("status--> " + statusCode.toString());
    String bodydetial = response.body;
    print(" body--> " + bodydetial);


    if (response.statusCode == 200) {
      Map jasonData = jsonDecode(response.body);
      print(jasonData['data']['otp']);
      //Map jsonn =jasonData['data'];
      //print(jsonn['otp']);
      getOTP = jasonData['data']['otp'];
      fcmID = jasonData['data']['fcm_id'];
      print(getOTP);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OTPScreen(
                opt: getOTP,
                phone: phnno,
              )));
      setState(() {});
    } else {
      FocusScope.of(context).requestFocus(focusNode);
      final snackBar = SnackBar(content: Text('Your Mobile No is Not Register',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
