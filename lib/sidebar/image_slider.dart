import 'dart:convert';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/model/SliderModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageSlider extends StatefulWidget {
  @override
  FetchFromNetworkState createState() => FetchFromNetworkState();

}

class FetchFromNetworkState extends State<ImageSlider> {

  Future<SliderModel>showslider() async {
    var endpointUrl = All_API().baseurl + All_API().api_slider;
    print("SliderUrl--> " + endpointUrl);
    Map<String, String> queryParameter = {
      'status': '1',
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print("requestUrl--> " + requestUrl);
    var response = await http.get(requestUrl, headers: {
      All_API().key: All_API().keyvalue,
    });
    print("Sliderresponse--> " + response.body);
    if (response.statusCode == 200) {
      var jasonDataSlider = jsonDecode(response.body);
      return SliderModel.fromJson(jasonDataSlider);
    }
  }
  List<String> listImage=[
  "assets/ayt.png",
  "assets/ayt.png",
  "assets/ayt.png",
  "assets/ayt.png",
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // print("List : "+imgUrls.length);
    return FutureBuilder<SliderModel>(
      future: showslider(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          var imgSliderpath=All_API().baseurl_img+snapshot.data.path;
          print("Sliderpath--> "+imgSliderpath);
          return CarouselSlider.builder(

            options: CarouselOptions(aspectRatio: 2.0, autoPlay: true),
            itemCount: snapshot.data.data.length,
            itemBuilder: (context, index) {
              var sliderimges = snapshot.data.data[index];
              print("Image : "+imgSliderpath+sliderimges.image);
              return Image.network(imgSliderpath+sliderimges.image, fit: BoxFit.fill, width: 2000, height: 100,);
            },
          );
        }
        else if(snapshot.hasData == false){
          return CarouselSlider.builder(

            options: CarouselOptions(aspectRatio: 2.0, autoPlay: true),
            itemCount: listImage.length,
            itemBuilder: (context, index) {

              return  Image.asset(listImage[index],height: 100,width: 80,);
            },
          );

        }
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

}