import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/Expenses/track_expenses.dart';
import 'package:AYT_Attendence/Screens/LoginScreen/login2.dart';
import 'package:AYT_Attendence/Screens/leavelists/track_leave.dart';
import 'package:AYT_Attendence/Screens/notification/NotificationScreen.dart';
import 'package:AYT_Attendence/Screens/webViews/about_us.dart';
import 'package:AYT_Attendence/Screens/webViews/contact_us.dart';
import 'package:AYT_Attendence/Screens/webViews/tearms_and_condition.dart';
import 'package:AYT_Attendence/pages/EarlyCheckOutRequest.dart';
import 'package:AYT_Attendence/pages/GeneralLeaves.dart';
import 'package:AYT_Attendence/pages/SalaryList.dart';
import 'package:AYT_Attendence/pages/dashboard.dart';
import 'package:AYT_Attendence/pages/trackattendance.dart';
import 'package:AYT_Attendence/sidebar/bottom.dart';
import 'package:AYT_Attendence/sidebar/foldable_sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'myaccountspage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  FSBStatus drawerStatus;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
              child: Text(
                'DASHBOARD', style: TextStyle(color: Colors.orange),),
            ),
            backgroundColor: Colors.blue[1000],
            toolbarHeight: 50,
            leading: new IconButton(
              icon: new Icon(Icons.menu,size: 30,color: Colors.orange,),
              onPressed: () {
                setState(() {
                  drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
                });
              },
            ),
          ),
        body: //FoldableSidebarBuilder(status: drawerStatus, drawer: CustomDrawer(), screenContents: Dashboard(),)
        FoldableSidebarBuilder(
          drawerBackgroundColor: Colors.orange,
          status:drawerStatus,
          drawer: CustomDrawer(closeDrawer: (){
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE;
            });
          },),
          screenContents: Dashboard(),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {

  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String name;
  String uniqId;
  String userphn;
  String userimg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      name=sharedPreferences.getString("name");
      uniqId=sharedPreferences.getString("unique_id");
      userphn=sharedPreferences.getString("phone");
      userimg=sharedPreferences.getString("image");
    });
  }

  @override
  Widget build(BuildContext context) {
    String path=All_API().baseurl_img+All_API().profile_img_path;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        color: Colors.blue[1000],
        width: mediaQuery.size.width * 0.60,
        child: Column(
          children: [
            Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: userimg!=null?Image.network(
                        path+userimg,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      ):Image.asset('assets/ayt.png',width: 110,
                        height: 110,
                        fit: BoxFit.cover,),
                      /*child: Image.asset(
                        "assets/ayt.png",
                        width: 110.0,
                        height: 110.0,
                        fit: BoxFit.fill,

                      ),*/
                    ),
                    /*Image.asset(
                      "assets/ayt.png",
                      width: 100,
                      height: 150,
                    ),*/
                    SizedBox(
                      height: 20,
                    ),
                    Text(name!=null?name:"ADIYOGI",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blue[1000])),
                    Text(userphn!=null?userphn:"1234567890",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blue[1000])),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            ListTile(
              onTap: (){
                print("Tapped Profile");
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen()));
                //closeDrewer();
              },
              leading: Icon(Icons.person,color: Colors.orange,),
              title: Text("Your Profile",style: TextStyle(color: Colors.orange),),
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped Notifications");
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),),);
              },
              leading: Icon(Icons.notifications,color: Colors.orange,),
              title: Text("Notifications",style: TextStyle(color: Colors.orange),),
            ),
            ListTile(
              onTap: (){
                print("Tapped Chat");
                //Navigator.push(context, MaterialPageRoute(builder: (context) => uID==null?BottomNavBar():ChatAllUser(),),);
              },
              leading: Icon(Icons.chat,color: Colors.orange,),
              title: Text("Chat",style: TextStyle(color: Colors.orange),),
            ),
            Divider(
              height: 1,
              color: Colors.deepOrange,
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped General");
                Navigator.push(context, MaterialPageRoute(builder: (context) => GeneralLeave(),),);
              },
              leading: Icon(Icons.article,color: Colors.orange,),
              title: Text("General Leave",style: TextStyle(color: Colors.orange),),
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped Track Attendance");
                Navigator.push(context, MaterialPageRoute(builder: (context) => TrackAttendance(),),);
              },
              leading: Icon(Icons.attribution_outlined,color: Colors.orange,),
              title: Text("Track Attendance",style: TextStyle(color: Colors.orange),),
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped Track Leave");
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyTrackLeave(),),);
              },
              leading: Icon(Icons.article,color: Colors.orange,),
              title: Text("Track Leave",style: TextStyle(color: Colors.orange),),
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped Early Checkout");
                Navigator.push(context, MaterialPageRoute(builder: (context) => EarlyCheckOutRequest(),),);
              },
              leading: Icon(Icons.outbond_outlined,color: Colors.orange,),
              title: Text("Early Checkout ",style: TextStyle(color: Colors.orange),),
            ),
            Divider(
              height: 1,
              color: Colors.deepOrange,
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped Expenses");
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyTrackExpenses(),),);
              },
              leading: Icon(Icons.explicit,color: Colors.orange,),
              title: Text("View Expenses",style: TextStyle(color: Colors.orange),),
            ),
            Divider(
              height: 1,
              color: Colors.deepOrange,
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped Salary");
                Navigator.push(context, MaterialPageRoute(builder: (context) => SalaryList(),),);
              },
              leading: Icon(Icons.money,color: Colors.orange,),
              title: Text("Salary Report",style: TextStyle(color: Colors.orange),),
            ),
            Divider(
              height: 1,
              color: Colors.deepOrange,
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped Contact");
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(),),);
              },
              leading: Icon(Icons.call,color: Colors.orange,),
              title: Text("Contact Us",style: TextStyle(color: Colors.orange),),
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped About");
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage(),),);
              },
              leading: Icon(Icons.assignment_late,color: Colors.orange,),
              title: Text("About Us",style: TextStyle(color: Colors.orange),),
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped Terms");
                Navigator.push(context, MaterialPageRoute(builder: (context) => TremsCondition(),),);
              },
              leading: Icon(Icons.assignment,color: Colors.orange,),
              title: Text("Terms & Condition",style: TextStyle(color: Colors.orange),),
            ),
            ListTile(
              onTap: () {
                debugPrint("Tapped Salary");
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(),),);
              },
              leading: Icon(Icons.privacy_tip,color: Colors.orange,),
              title: Text("Privacy Policy",style: TextStyle(color: Colors.orange),),
            ),
            Divider(
              height: 1,
              color: Colors.deepOrange,
            ),
            ListTile(
              onTap: () async {
                debugPrint("Tapped Log Out");
                if(uniqId.toString().isNotEmpty){
                  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                  sharedPreferences.setBool("loggedIn", false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyLogin2(),),);
                }
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(),),);
              },
              leading: Icon(Icons.exit_to_app,color: Colors.orange),
              title: Text("Log Out",style: TextStyle(color: Colors.orange),),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _refreshLocalGallery() async {
    print('refreshing stocks...');
  }
}


