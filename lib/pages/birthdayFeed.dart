import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/model/BirthdayModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class birthdayFeed extends StatefulWidget {
  @override
  birthdayFeedState createState() => birthdayFeedState();
}

class birthdayFeedState extends State<birthdayFeed> {
  Future<Birthdaymodel> newsdetail() async {
    var endpointUrl = All_API().baseurl + All_API().api_birthday;
    Map<String, String> queryParameter = {
      '': '',
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print(requestUrl);
    try {
      var response = await http.get(requestUrl, headers: {
        All_API().key: All_API().keyvalue,
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print("Birthday : " + jsonString);
        var jsonMap = json.decode(jsonString);
        return Birthdaymodel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return Exception;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('HAPPY BIRTHDAY',
                style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,
                    color: Colors.blue[1000]),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 8,
          child: FutureBuilder<Birthdaymodel>(
            future: newsdetail(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var path = All_API().baseurl_img + snapshot.data.path;
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var article = snapshot.data.data[index];
                      print("birthdayimg-->" + path + article.image);
                      print("birthdayname-->" + article.name);
                      return   Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                width: 160,
                                child: InkWell(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 110,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(path + article.image),
                                                  fit: BoxFit.contain
                                              ),
                                            ),
                                          ),
                                          /*ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Ink.image(
                                    height: 130,

                                    image: NetworkImage(path + article.image),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),*/
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, top: 16, right: 16, bottom: 16),
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(child:Text(
                                                article.name,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blue[1000],
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                              ),),

                                              Center(child:   Text(
                                                article.designation,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.orange,
                                                    fontWeight: FontWeight.normal),
                                                maxLines: 1,
                                              ),),
                                              /*Container(
                                      color: Colors.blue[1000],
                                      width: 300,
                                      height: 30,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(1.0),
                                      child:
                                    ),*/
                                              /* Container(
                                      color: Colors.blue[1000],
                                      width: 300,
                                      height: 30,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(1.0),
                                      child:
                                    ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                    });
              } else if (snapshot.hasData == false) {
                return Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      width: 200,
                      child: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Ink.image(
                                    height: 130,
                                    image: AssetImage("assets/ayt.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                /*Ink.image(
                            height:130,
                            image: AssetImage("assets/ayt.png"),
                            fit: BoxFit.contain,),*/
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16, top: 16, right: 16, bottom: 16),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Naveen Chouhan",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                    ),
                                    Text(
                                      "Jr. Android developer",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.normal),
                                      maxLines: 1,
                                    ),
                                    /* Container(
                                color: Colors.blue[1000],
                                width: 300,
                                height: 30,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(1.0),
                                child:
                              ),
                              Container(
                                color: Colors.blue[1000],
                                width: 300,
                                height: 30,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(1.0),
                                child:
                              ),*/
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}