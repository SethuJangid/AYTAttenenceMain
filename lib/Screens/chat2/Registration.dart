import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/chat2/widget.dart';
import 'package:AYT_Attendence/Screens/chat2/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Chating2.dart';
import 'auth2.dart';
import 'helperfunctions2.dart';

class Registration extends StatefulWidget {
  final Function toggleView;

  Registration(this.toggleView);


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<Registration> {
  /*String path=All_API().baseurl_img+All_API().profile_img_path;
  String name;
  String uniqID;
  String email;
  String password;
  String uniqId;
  String userphn;
  String userimg;

  AuthService2 authService = new AuthService2();
  DatabaseMethods2 databaseMethods = new DatabaseMethods2();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String image;

  getData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      name=sharedPreferences.getString("name");
      uniqID=sharedPreferences.getString("unique_id");

      userphn = sharedPreferences.getString("phone");
      userimg = sharedPreferences.getString("image");
      email = sharedPreferences.getString("email");
      password = sharedPreferences.getString("password");
      image = path+userimg;
    });
  }

  singUp() async {
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      await authService.signUpWithEmailAndPassword(email,
          password).then((result){
        if(result != null){
          Map<String,String> userDataMap = {
            "userName" : name,
            "userEmail" : email,
            "userImage" : image,
          };
          databaseMethods.addUserInfo(userDataMap);
          HelperFunctions2.saveUserLoggedInSharedPreference(true);
          HelperFunctions2.saveUserNameSharedPreference(name);
          HelperFunctions2.saveUserEmailSharedPreference(email);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBarMain2(context),
      //body:
      /*isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) :  Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Spacer(),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: simpleTextStyle(),
                    //controller: usernameEditingController,
                    validator: (val){
                      return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                    },
                    decoration: textFieldInputDecoration("username"),
                  ),
                  TextFormField(
                    //controller: emailEditingController,
                    style: simpleTextStyle(),
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                      null : "Enter correct email";
                    },
                    decoration: textFieldInputDecoration("email"),
                  ),
                  TextFormField(
                    obscureText: true,
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration("password"),
                    //controller: passwordEditingController,
                    validator:  (val){
                      return val.length < 6 ? "Enter Password 6+ characters" : null;
                    },

                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: (){
                singUp();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
                    )),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Sign Up",
                  style: biggerTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: simpleTextStyle(),
                ),
                GestureDetector(
                  onTap: () {
                    widget.toggleView();
                  },
                  child: Text(
                    "SignIn now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),*/
    );
    ;
  }
}
