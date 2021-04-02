import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:AYT_Attendence/API/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileThreePageState createState() => _ProfileThreePageState();
}

class _ProfileThreePageState extends State<ProfileScreen> {
  bool _load = false;
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

  String designation;
  String department;

  var statusCode;
  Timer timer;

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
  showData()async{
    department_user_id(department_id);
    designation_user_id(designation_id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    String path=All_API().baseurl_img+All_API().profile_img_path;
    var duration=new Duration(seconds: 1);
    Timer(duration, showData);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[1000],
        title: Container(
          margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          child: Text(
            'Profile ',
            style: TextStyle(color: Colors.orange),
          ),
        ),
        /*leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.orange,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                image!=null?path+image:"assets/ayt.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              margin: EdgeInsets.only(left: 96.0),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    name!=null?name:'Adiyogi',
                                    style: Theme.of(context).textTheme.title,
                                  ),

                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(designation!=null?designation:'Designation'),
                                    subtitle: Text(department!=null?department:'Department'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Center(child:RaisedButton(
                              child: Text('UpLoad Image'),
                              color: Colors.orange,
                              textColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.blue[1000])
                              ),
                              padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                              splashColor: Colors.blue[1000],
                              onPressed: () async {
                                //onpressed gets called when the button is tapped.
                                var imagepicker = await ImagePicker.pickImage(source: ImageSource.gallery);
                                if(imagepicker!=null){
                                  setState(() {
                                    print("profileUpload_imagepicker--> " + imagepicker.path);
                                    uploadimage=imagepicker ;

                                    profileUpload(uploadimage);
                                    //
                                  });
                                }
                              },
                            ),),
                            /*Row(
                              children: <Widget>[
                                GestureDetector(
                                  child: Text("Upload Image"),
                                  onTap: () async{

                                  },
                                )
                              ],
                            ),*/
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: NetworkImage(image!=null?path+image:"assets/ayt.png",), fit: BoxFit.cover)),
                        margin: EdgeInsets.only(left: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Employee information"),
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text(email!=null?email:''),
                          leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text(phone!=null?phone:''),
                          leading: Icon(Icons.phone),
                        ),
                        ListTile(
                          title: Text("Employee Id"),
                          subtitle: Text(user_unique_id!=null?user_unique_id:''),
                          leading: Icon(Icons.person),
                        ),
                        ListTile(
                          title: Text("Date of Birth"),
                          subtitle: Text(dob!=null?dob:''),
                          leading: Icon(Icons.date_range),
                        ),
                        ListTile(
                          title: Text("Joined Date"),
                          subtitle: Text(joining_date!=null?joining_date:''),
                          leading: Icon(Icons.calendar_view_day),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),);
  }
  void department_user_id(String departmentID) async {
    var endpointUrl = All_API().baseurl+All_API().api_department + departmentID;
    print("department URL--->"+endpointUrl);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var response = await http.get(endpointUrl,headers: headers);
    statusCode=response.statusCode;
    if(statusCode==200){
      setState(() {
        Map jasonData = jsonDecode(response.body);
        department=jasonData['data']['name'];
        print('Department : '+department);
        print('Department Data : '+jasonData.toString());
      });

    }
  }
  void designation_user_id(String designationID) async {
    var endpointUrl = All_API().baseurl+All_API().api_designation + designationID;
    print("designation URL--->"+endpointUrl);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var response = await http.get(endpointUrl,headers:headers );
    if(statusCode==200){

      setState(() {
        Map jasonData = jsonDecode(response.body);
        designation=jasonData['data']['name'];
        print('Designation : '+designation);
        print('Designation Data : '+jasonData.toString());
      });

    }
  }

  void profileUpload(File uploadimage) async {
    //String uni_id="NODS5X5N5V2H2Z";
    loadingdialog();
    String url = All_API().baseurl +All_API().api_profile+uniqId;
    print("profile image URL--->"+url);
    String filename = uploadimage.path.split("/image_picker").last;
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', uploadimage.path));
    request.headers.addAll(headers);
    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      setState(() {
        _load=false;
        Map jsonData=jsonDecode(respStr);
        String path=jsonData['path'];
        String imageSplit=path.split('/').last;
        image=imageSplit.trim();
        final snackBar = SnackBar(content: Text('Your Profile Successfully Updated',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
        //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print("Uploaded Image--> "+imageSplit);
        print("Uploaded Image--> "+path);
      });


    }
    else {
      final snackBar = SnackBar(content: Text('Your Profile Image Not Successfully Updated',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("profileUpload_reasonPhrase--> "+response.reasonPhrase);
    }
  }

  void loadingdialog() {

    _load=true;
    if(_load==true){
      CircularProgressIndicator();
      final snackBar = SnackBar(content: Text('Uploading Image',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }else{

    }
  }
}