import 'dart:convert';
import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/model/SalaryModel.dart';
import 'package:AYT_Attendence/pages/SalaryDetails.dart';
import 'package:AYT_Attendence/sidebar/bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SalaryList extends StatefulWidget {
  @override
  SalaryListState createState() => SalaryListState();

}

class SalaryListState extends State<SalaryList> {
  String name;
  String date;
  String uniqID;
  String latitude;
  String longitude;
  String action;
  String address;
  String device;
  String action_check;
  @override
  void initState() {
    // TODO: implement initState
    date = DateFormat("yyyy/MM/dd HH:mm:ss").format(DateTime.now());
    print(date); //
    super.initState();
    getData();
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
      device=sharedPreferences.getString("device");
    });
  }
  int _id;
  Future<SalaryModel>salary() async {
    var endpointUrl = All_API().baseurl + All_API().api_salary_list+uniqID;
    print("SalaryUrl--> " + endpointUrl);
    // Map<String, String>  queryParameter={
    //   '':'',
    // };
    // String queryString = Uri(queryParameters: queryParameter).query;
    // var requestUrl = endpointUrl + '?' + queryString;
    // print(requestUrl);
    try {
      var response = await http.get(endpointUrl,headers: {
        All_API().key: All_API().keyvalue,
      });
      print("Salaryresponse--> " + response.body);
      if(response.statusCode==200){
        var jasonDataNews = jsonDecode(response.body);
        return SalaryModel.fromJson(jasonDataNews);
      }
      else{
        final snackBar = SnackBar(content: Text('No Record Found',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.orange,);
        //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(),
          ),
        );
      }
    }
    catch(Exception){
      return Exception;
    }
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
          'Salary List', style: TextStyle(color: Colors.orange),),
      ),
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),),
        body: FutureBuilder<SalaryModel>(
            future: salary(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      var salarylist = snapshot.data.data[index];
                      String cr=salarylist.creditDate.toString().split(' ').last;
                      String date=cr[0].trim();
                      return GestureDetector(
                        onTap:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalaryDetails(id: salarylist.employeeId,month: salarylist.month,CreditDate: date,),
                            ),
                          );
                          setState(() {
                            _id = index;
                          });
                        },
                        child: Card(
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
                                leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                        right: new BorderSide(width: 1.0, color: Colors.white70),
                                        // left: new BorderSide(width: 2.0, color: Colors.amber)
                                      )),
                                  child: Icon(Icons.attach_money, color: Colors.orange),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    salarylist.netSalary+" Rs"+" / "+salarylist.ctc+" Rs",
                                    style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Row(

                                  children: <Widget>[
                                    Icon(Icons.date_range_rounded , color: Colors.yellowAccent),
                                    Text(" "+salarylist.month, style: TextStyle(color: Colors.white)),

                                  ],
                                ),
                                trailing:
                                Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),

                          ),
                        ),
                      );
                    }
                );
              }
              else
                return Center(child: CircularProgressIndicator());
            }
        ),
      ),
    );
  }
}