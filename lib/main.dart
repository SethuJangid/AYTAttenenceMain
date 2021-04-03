
import 'package:AYT_Attendence/Screens/ChatingPage/ChatMain.dart';
import 'package:AYT_Attendence/Screens/Splash/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Splash/animation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}
class MyHomePageState extends State<MyHomePage> {
  String _message = '';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  void getMessage(){
    _firebaseMessaging.getToken().then((token) => print(token));
    _firebaseMessaging.getToken().then((token) {
      String fcmID  = token.toString();
      sharedPreferences.setString('fcmID', fcmID);
      // do whatever you want with the token here
    });
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          setState(() => _message = message["notification"]["title"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"]);
    });
  }

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  SharedPreferences sharedPreferences;

  Position _currentPosition;
  String _currentAddress;

  Future<void> getPermission() async{
    sharedPreferences=await SharedPreferences.getInstance();
    PermissionStatus permission=await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if(permission==PermissionStatus.denied)
    {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator=Geolocator();

    GeolocationStatus geolocationStatus=await geolocator.checkGeolocationPermissionStatus();

    switch(geolocationStatus)
    {
      case GeolocationStatus.disabled:
        print('Disabled');
        break;
      case GeolocationStatus.restricted:
        print('Restricted');
        break;
      case GeolocationStatus.denied:
        print('Denid');
        break;
      case GeolocationStatus.unknown:
        print('Unknown');
        break;
      case GeolocationStatus.granted:
        print('Granded');
        _getCurrentLocation();
        break;
    }



  }

  @override
  void initState() {
    // TODO: implement initState
    getPermission();
    _getAddressFromLatLng();
    _getCurrentLocation();
    getCurrentDate();
    getMessage();
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  getCurrentDate()async{
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day );
    //print("Today Date : "+date.toString());
    setState(() {
      //sharedPreferences.setString("date", date.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
            children: <Widget>[
              Scaffold(
                /*appBar: AppBar(
                    title: Text('Raindrop App'),
                  ),*/
                  body: ChatScreen()
                //body: GeneralLeave(),
              ),
              /*IgnorePointer(
                  child: AnimationScreen(
                      color: Colors.blue[1000]
                  )
              )*/
            ]
        )
    );
  }
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        //print("Position : "+_currentPosition.toString());
        sharedPreferences.setString("lat", _currentPosition.latitude.toString());
        sharedPreferences.setString("long", _currentPosition.longitude.toString());
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
        //print("Address : "+_currentAddress);
        sharedPreferences.setString("address", _currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }
}