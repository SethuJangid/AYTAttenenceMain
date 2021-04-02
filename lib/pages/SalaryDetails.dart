import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/model/GeneralLeaveModel.dart';
import 'package:AYT_Attendence/model/SalaryDetailModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SalaryDetails extends StatefulWidget {
  String id;
  String month;
  String CreditDate;
  SalaryDetails({this.id, this.month, this.CreditDate});
  @override
  _SalaryDetailsState createState() => _SalaryDetailsState();
}

class _SalaryDetailsState extends State<SalaryDetails> {
  Future<SalaryDetailModel> loadStudent() async {
    await wait(5);
    var endpointUrl = All_API().baseurl +
        All_API().api_salary_detail +
        widget.id +
        "/" +
        widget.month;
    print("SalaryUUUU" + endpointUrl);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    var response = await http.get(endpointUrl, headers: headers);
    var jasonData = jsonDecode(response.body);
    print('General : ' + jasonData.toString());
    return SalaryDetailModel.fromJson(jasonData);
  }

  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue[1000],
        title: Container(
          margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          child: Text(
            'Salary Details',
            style: TextStyle(color: Colors.orange),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.orange,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<SalaryDetailModel>(
            future: loadStudent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Text("Adiyogi Technosoft Pvt. Ltd.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 2.0,
                            color: Colors.deepOrange,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding:EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                        right: new BorderSide(width: 1.0, color: Colors.orange),
                                        // left: new BorderSide(width: 2.0, color: Colors.amber)
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Name",style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Designation",style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Joining Date",style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Current CTC",style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.data.length,
                                        itemBuilder: (context,index){
                                          var listSD=snapshot.data.data[index];
                                          return Container(
                                            padding:EdgeInsets.only(left: 12.0),
                                            decoration: new BoxDecoration(
                                                border: new Border(
                                                  left: new BorderSide(width: 1.0, color: Colors.orange),
                                                  // left: new BorderSide(width: 2.0, color: Colors.amber)
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listSD.name),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listSD.designation),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listSD.joiningDate.toString()),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listSD.grossSalary.toString()),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),

                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                      thickness: 2.0,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Center(child: Text("Salary Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.deepOrange,
                            thickness: 2.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(

                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Cross Salary"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Total Working Day"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Leaves"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Pay Rate(Per Day)"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.data.length,
                                        itemBuilder: (context,index){
                                          var listSD=snapshot.data.data[index];
                                          return Container(
                                            padding:EdgeInsets.only(left: 12.0),
                                            decoration: new BoxDecoration(
                                                border: new Border(
                                                  left: new BorderSide(width: 1.0, color: Colors.orange),
                                                  // left: new BorderSide(width: 2.0, color: Colors.amber)
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listSD.grossSalary),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listSD.totalWorkingDays),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listSD.leave.toString()),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listSD.perDaySalary.toString()),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),

                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                      thickness: 2.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding:EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                    right: new BorderSide(width: 1.0, color: Colors.orange),
                                    // left: new BorderSide(width: 2.0, color: Colors.amber)
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text("CREDIT",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text("DEBIT",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                      thickness: 2.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.data.length,
                                    itemBuilder: (context,index){
                                      var listSD=snapshot.data.data[index];
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: listSD.credit.length,
                                        itemBuilder: (context,index){
                                          var listDeduct=listSD.credit[index];
                                          print("CREDIT"+listDeduct.name);
                                          return Container(
                                            padding:EdgeInsets.only(left: 12.0),
                                            decoration: new BoxDecoration(
                                                border: new Border(
                                                  left: new BorderSide(width: 1.0, color: Colors.orange),
                                                  // left: new BorderSide(width: 2.0, color: Colors.amber)
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listDeduct.name),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listDeduct.value.toString()),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),

                          ),
                          Expanded(
                            flex: 4,
                            child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.data.length,
                                    itemBuilder: (context,index){
                                      var listSD=snapshot.data.data[index];
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: listSD.deduct.length,
                                        itemBuilder: (context,index){
                                          var listDeduct=listSD.deduct[index];
                                          print("DEDUCT"+listDeduct.name);
                                          return Container(
                                            padding:EdgeInsets.only(left: 12.0),
                                            decoration: new BoxDecoration(
                                                border: new Border(
                                                  left: new BorderSide(width: 1.0, color: Colors.orange),
                                                  // left: new BorderSide(width: 2.0, color: Colors.amber)
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listDeduct.name),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(listDeduct.value.toString()),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.data.length,
                                    itemBuilder: (context,index){
                                      var listSD=snapshot.data.data[index];
                                      return Container(
                                        padding:EdgeInsets.only(left: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                              left: new BorderSide(width: 1.0, color: Colors.orange),
                                              // left: new BorderSide(width: 2.0, color: Colors.amber)
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Total Credit : "+listSD.totalCredit.toString() +" RS"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          Expanded(
                            flex: 3,
                            child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.data.length,
                                    itemBuilder: (context,index){
                                      var listSD=snapshot.data.data[index];
                                      return Container(
                                        padding:EdgeInsets.only(left: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                              left: new BorderSide(width: 1.0, color: Colors.orange),
                                              // left: new BorderSide(width: 2.0, color: Colors.amber)
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Total Deduct : "+listSD.totalDeduct.toString() +" RS"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                      thickness: 2.0,
                    ),
                    Container(
                      child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context,index){
                                var listSD=snapshot.data.data[index];
                                return Container(
                                  padding:EdgeInsets.only(left: 12.0),
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                        left: new BorderSide(width: 1.0, color: Colors.orange),
                                        // left: new BorderSide(width: 2.0, color: Colors.amber)
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Net Payable Salary : "+listSD.netSalary.toString() +" RS"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                    ),
                    Divider(
                      height: 1,
                      color: Colors.deepOrange,
                      thickness: 2.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding:EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                    right: new BorderSide(width: 1.0, color: Colors.orange),
                                    bottom: new BorderSide(width: 1.0, color: Colors.orange),
                                    // left: new BorderSide(width: 2.0, color: Colors.amber)
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text("Salary Month : "+widget.month),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding:EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                    //right: new BorderSide(width: 1.0, color: Colors.orange),
                                    bottom: new BorderSide(width: 1.0, color: Colors.orange),
                                    // left: new BorderSide(width: 2.0, color: Colors.amber)
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text("Credit Date : "+widget.CreditDate!=null?widget.CreditDate:"Pending"),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else
                return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
