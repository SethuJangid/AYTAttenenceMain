import 'dart:convert';
import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/model/LeaveModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


class leaveFeed extends StatefulWidget{
  leaveFeed({this.unique_id});
  final String unique_id;
  @override
  _leaveFeedState createState() => _leaveFeedState();
}

class _leaveFeedState extends State<leaveFeed> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<LeaveModelData> loadStudent() async {
    print("UNIQ ID Leave--->"+widget.unique_id);
    //await wait(5);
    var endpointUrl = All_API().baseurl+All_API().api_leave_type + widget.unique_id;
    //print("LeavesendpointUrl -->"+All_API().baseurl+All_API().api_leave_type+widget.unique_id);
    print('LeavesendpointUrl : '+endpointUrl);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };

    var response = await http.get(endpointUrl,headers: headers);

    Map jasonData = jsonDecode(response.body);
    print('Leaves : '+jasonData.toString());
    return new LeaveModelData.fromJson(jasonData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LeaveModelData>(
      future: loadStudent(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(
              itemCount: snapshot.data.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                var article = snapshot.data.data[index];
                return Expanded(child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Colors.orange,  // red as border color
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white54,
                          offset: Offset(0, 5),
                          blurRadius: 10.0),
                      BoxShadow(
                          color: Colors.white60,
                          offset: Offset(0, 5),
                          blurRadius: 10.0)
                    ],
                  ),
                  margin:const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 5),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Expanded(flex:2,child: Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.red,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                ),
                              ),),
                              Expanded(flex:2,child: Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment:
                                  Alignment.bottomCenter,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Text(
                                      "USED",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),),
                            ],
                          ),
                          Column(
                            children: [
                              Expanded(flex:2,child:Container(

                                alignment: Alignment.center,
                                child: Text("Paid Leave",style: TextStyle(fontSize: 18,color: Colors.black),),
                              ),),

                              Expanded(flex:2,child:Container(

                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Center(child: Text("0",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight:
                                    FontWeight.bold),)),
                                    Center(child: Text("ALLOWED",style: TextStyle(fontSize: 10,color: Colors.black),))
                                  ],
                                ),
                              ),),

                            ],
                          )
                        ],
                      )
                      ,
                    ],
                  ),
                ), );
              }
          );
        }
        else if(snapshot.hasData == false){
          return Container(
            width: 160,
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(
                color: Colors.orange,  // red as border color
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.white54,
                    offset: Offset(0, 5),
                    blurRadius: 10.0),
                BoxShadow(
                    color: Colors.white60,
                    offset: Offset(0, 5),
                    blurRadius: 10.0)
              ],
            ),
            margin:const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 5),
            child: Row(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Expanded(flex:2,child: Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.red,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                          ),
                        ),),
                        Expanded(flex:2,child: Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child: Container(
                            alignment:
                            Alignment.bottomCenter,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: Text(
                                "USED",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                            ),
                          ),
                        ),),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(flex:2,child:Container(

                          alignment: Alignment.center,
                          child: Text("Paid Leave",style: TextStyle(fontSize: 18,color: Colors.black),),
                        ),),

                        Expanded(flex:2,child:Container(

                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Center(child: Text("0",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight:
                              FontWeight.bold),)),
                              Center(child: Text("ALLOWED",style: TextStyle(fontSize: 10,color: Colors.black),))
                            ],
                          ),
                        ),),

                      ],
                    )
                  ],
                )
                ,
              ],
            ),
          );
        }
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}