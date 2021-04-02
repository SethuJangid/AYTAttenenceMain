import 'dart:convert';
import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/model/NewsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'All_News.dart';


class newsFeeds extends StatefulWidget{
  @override
  newsFeedsState createState() => newsFeedsState();
}

class newsFeedsState extends State<newsFeeds> {
  String statuscode;
  Future<Newsmodel>newsdetail() async {
    var endpointUrl = All_API().baseurl + All_API().api_news;
    Map<String, String>  queryParameter={
      'status':'1',
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print(requestUrl);
    try {
      var response = await http.get(requestUrl,headers: {
        All_API().key: All_API().keyvalue,
      });
      print("News : "+response.body);
      print("StatusCODE : "+response.statusCode.toString());
       statuscode=response.statusCode.toString();
      if(response.statusCode==200){
        var jsonString = response.body;
        print("News : "+jsonString);
        var jsonMap = json.decode(jsonString);
        return Newsmodel.fromJson(jsonMap);
      }
    }
    catch(Exception){
      return Exception;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex:3,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('News Feeds',
                      style: TextStyle(
                        fontSize: 20, color: Colors.blue[1000],),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex:1,child: Container(
                  child: GestureDetector(

                    onTap: (){
                      if(statuscode==200){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>All_News()));
                      }else{
                        final snackBar = SnackBar(content: Text('No Data Found',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
                        //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.remove_red_eye,size: 30,),
                    ),
                  ))),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: FutureBuilder<Newsmodel>(
            future: newsdetail(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var path=All_API().baseurl_img+snapshot.data.path;
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      var article = snapshot.data.data[index];
                      return Row(
                        children: [
                          Card(
                            elevation: 8,
                            child: Container(
                              width: 350,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white10,
                                      offset: Offset(0, 20),
                                      blurRadius: 30.0),
                                  BoxShadow(
                                      color: Colors.white30,
                                      offset: Offset(0, 20),
                                      blurRadius: 30.0)
                                ],
                              ),
                              child:Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: Image.network(path+article.image,),
                                      title: Text(article.title,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 2,),
                                      subtitle: Text(article.description,style: TextStyle(fontSize: 12,color: Colors.black),maxLines: 2,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                );
              }else if(snapshot.hasData==false){
                return  Row(
                    children: [
                      Card(
                        elevation: 8,
                        child: Container(
                          width: 350,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white10,
                                  offset: Offset(0, 20),
                                  blurRadius: 30.0),
                              BoxShadow(
                                  color: Colors.white30,
                                  offset: Offset(0, 20),
                                  blurRadius: 30.0)
                            ],
                          ),
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Image.asset("assets/ayt.png",height: 100,width: 50,),
                                  title: Text("Tital",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 2,),
                                  subtitle: Text("Description",style: TextStyle(fontSize: 12,color: Colors.black),maxLines: 2,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
              }
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}