import 'dart:convert';
import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Widgets/SizeConfig.dart';
import 'package:AYT_Attendence/model/TrackDashboardModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EaelyCheck_IN_OUT extends StatefulWidget {
  @override
  leaveFeedState createState() => leaveFeedState();
}

class leaveFeedState extends State<EaelyCheck_IN_OUT> {
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
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name");
      uniqID = sharedPreferences.getString("unique_id");
      latitude = sharedPreferences.getString("lat");
      longitude = sharedPreferences.getString("long");
      action = sharedPreferences.getString("");
      address = sharedPreferences.getString("address");
      device = sharedPreferences.getString("device_id");
      print("UNIQ ID --->" + uniqID);
    });
  }

  Future<TrackDashboardModel> trackdashStudent() async {
    String device_id = device;
    String unique_id = uniqID;
    var endpointUrl = All_API().baseurl +
        All_API().api_tack_dashboard +
        unique_id +
        "/" +
        device_id;
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
    };
    Map<String, String> queryParameter = {
      'latitute': latitude,
      'longitute': longitude,
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print(requestUrl);
    var response = await http.get(requestUrl, headers: headers);

    Map jasonData = jsonDecode(response.body);
    print('EarlyCheckInOut : ' + jasonData.toString());
    return TrackDashboardModel.fromJson(jasonData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        /*height: SizeConfig.safeBlockVertical * 100, //10 for example
        width: SizeConfig.safeBlockHorizontal * 100, *///10 for example
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<TrackDashboardModel>(
            future: trackdashStudent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var article = snapshot.data.data[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(
                                color: Colors.orange, // red as border color
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
                                    color: Colors.white60, offset: Offset(0, 5), blurRadius: 10.0)
                              ],
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  article.counterRecord[index]
                                                      .lateCheckin
                                                      .toString(),
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "USED",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                width: 100,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Late CheckIn",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Center(
                                                            child: Text(
                                                              article
                                                                  .counterRecord[
                                                              index]
                                                                  .totalLateCheckin
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold),
                                                            )),
                                                        Center(
                                                            child: Text(
                                                              "ALLOWED",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold),
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(
                                color: Colors.orange, // red as border color
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
                                    color: Colors.white60, offset: Offset(0, 5), blurRadius: 10.0)
                              ],
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                article.counterRecord[index]
                                                    .earlyCheckout
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "USED",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                width: 100,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Early CheckOut",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Center(
                                                            child: Text(
                                                              article
                                                                  .counterRecord[
                                                              index]
                                                                  .totalEarlyCheckout
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold),
                                                            )),
                                                        Center(
                                                            child: Text(
                                                              "ALLOWED",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold),
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              } else if (snapshot.hasData == false) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(
                          color: Colors.orange, // red as border color
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
                              color: Colors.white60, offset: Offset(0, 5), blurRadius: 10.0)
                        ],
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "USED",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: 100,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Late CheckIn",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Center(
                                                      child: Text(
                                                        "5",
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                  Center(
                                                      child: Text(
                                                        "ALLOWED",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold),
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(
                          color: Colors.orange, // red as border color
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
                              color: Colors.white60, offset: Offset(0, 5), blurRadius: 10.0)
                        ],
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "USED",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: 100,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Early CheckOut",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Center(
                                                      child: Text(
                                                        "5",
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                  Center(
                                                      child: Text(
                                                        "ALLOWED",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold),
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
