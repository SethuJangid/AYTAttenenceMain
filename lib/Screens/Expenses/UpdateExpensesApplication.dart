import 'dart:io';

import 'package:AYT_Attendence/API/api.dart';
import 'package:AYT_Attendence/Screens/Expenses/track_expenses.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

final PermissionHandler permissionHandler = PermissionHandler();

class UpdateExpensesApplication extends StatefulWidget {
  String id;
  String date;
  String employeeID;
  String image;
  String expenseID;
  String expenseType;
  String expenseValue;
  String description;
  String expenseName;
  UpdateExpensesApplication(
      {
        this.id,
        this.date,
        this.employeeID,
        this.image,
        this.expenseID,
        this.expenseType,
        this.expenseValue,
        this.description,
        this.expenseName,
      });
  @override
  LeaveApplicationWidgetState createState() => LeaveApplicationWidgetState();
}

class LeaveApplicationWidgetState extends State<UpdateExpensesApplication>
    with SingleTickerProviderStateMixin {

  File image;
  var leaveID;
  bool isChecked = false;
  var labels;
  var msg;
  var kmvalue;
  var ExpensesType;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  DateTime currentDate = DateTime.now();
  var dateFrom;
  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        var str = currentDate.toString();
        var Strdate = str.split(" ");
        dateFrom = Strdate[0].trim();
      });
  }

  @override
  void initState() {
    super.initState();
    ExpensesStudent();
    var str=widget.date;
    var Strdate=str.split(" ");
    var date = Strdate[0].trim();
    dateFrom = date;
    leaveID = widget.expenseID;
    msg = widget.description;
    kmvalue = widget.expenseValue;
    ExpensesType = widget.expenseType;
    selectedvalue = widget.expenseName;
  }

  Future uploadmultipleimage() async {
    var url = All_API().baseurl + All_API().api_update_expense;
    print("Employee Update URL--->"+url);
    print("Employee ID--->"+widget.employeeID);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'Content-Type': 'multipart/form-data'
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['id'] = widget.id;
    request.fields['employee_id'] = widget.employeeID;
    request.fields['expense_id'] = leaveID;
    request.fields['type'] = ExpensesType;
    request.fields['value'] = kmvalue;
    request.fields['description'] = msg;
    request.fields['date'] = dateFrom;
    request.files.add(await http.MultipartFile.fromPath('image[]', image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print("Update Expenses ----> "+respStr);
    final snackBar = SnackBar(content: Text('Your Expenses Uploaded',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context) => MyTrackExpenses(),),);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  ServiceStatus serviceStatus;

  String selectedvalue;
  List<dynamic> ExpensesTypeList = List();
  Future ExpensesStudent() async {
    serviceStatus =
    await PermissionHandler().checkServiceStatus(PermissionGroup.storage);
    var endpointUrl = All_API().baseurl + All_API().api_type_expense_list;
    Map<String, String> queryParameter = {
      'status': '1',
    };
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + '?' + queryString;
    print("requestUrl--> " + requestUrl);

    var response = await http.get(requestUrl, headers: {
      All_API().key.toUpperCase(): All_API().keyvalue.toUpperCase(),
    });
    print("ExpensesResponse--> " + response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> jasonDataNotification = jsonDecode(response.body);
      setState(() {
        ExpensesTypeList = jasonDataNotification['data'];
      });
    } else {}
    print("ExpensesTypeList-->" + ExpensesTypeList.toString());
  }

  int leaveIndex = -1;
  List<Widget> list = null;

  String _errorMessage;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(
              body1: TextStyle(
                  color: Colors.black87,
                  fontFamily: "poppins-medium",
                  fontSize: 15,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400),
              button: TextStyle(
                  color: Colors.black87,
                  fontFamily: "poppins-medium",
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900))),
      home: Scaffold(
        // resizeToAvoidBottomPadding: true,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text('Expenses Update ',style: TextStyle(color: Colors.orange),),
            backgroundColor: Colors.blue[1000],
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Builder(
                      builder: (context) => Form(
                        //key: _formKey,
                          child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                Row(

                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Choose Date',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                0, 5, 0, 20),
                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(5.0)),
                              elevation: 4.0,
                              onPressed: () {
                                _selectDateFrom(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                dateFrom != null
                                                    ? dateFrom
                                                    : "",
                                                style: TextStyle(
                                                  color:
                                                  Colors.blue,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),

                                  ],
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: Text('Type of Expenses',style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                                ),
                                Column(
                                  children: <Widget>[
                                    DropdownButton(
                                      isExpanded: true,
                                      hint: Text(selectedvalue!=null?selectedvalue:"Select Expenses",style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                      value: selectedvalue,
                                      items: ExpensesTypeList.map((explist) {
                                        return DropdownMenuItem(
                                          value: explist['name'],
                                          child: Text(explist['name']),
                                          onTap: () {
                                            ExpensesType = explist['type'];
                                            leaveID = explist['id'];
                                            print(ExpensesType);
                                          },
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedvalue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                TextField(
                                  autofocus: false,
                                  controller: _textEditingController,
                                  decoration: new InputDecoration(
                                    hintText: kmvalue!=null?kmvalue:'Enter Value',
                                    labelText: "Expenses Price: "+ExpensesType!=null?ExpensesType:'Expenses Price',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black54),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black54),
                                    ),
                                  ),
                                ),
                                TextField(
                                  autofocus: false,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  controller: _textEditingController2,
                                  onSubmitted:
                                  _giveData(_textEditingController2),
                                  decoration: new InputDecoration(
                                    hintText: msg!=null?msg:'Enter Description',
                                    labelText: msg != null
                                        ? msg
                                        :"Description",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black54),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black54),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          RaisedButton(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 16.0),
                                                child: Text(
                                                  "Choose Images",
                                                  style: TextStyle(
                                                      color: Colors.orange),
                                                ),
                                              ),
                                              color: Colors.blue[1000],
                                              hoverColor: Colors.blue[1000],
                                              hoverElevation: 40.0,
                                              onPressed: () {
                                                pickImages();
                                              })
                                        ],
                                      ),
                                      //Image.file(image)
                                      widget.image!=null?Image.network(widget.image,fit: BoxFit.fill,height: 100,width: 200,):'',
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 16.0),
                                    child: RaisedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 16.0),
                                          child: Text(
                                            "APPLY EXPENSES",
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        color: Colors.orange,
                                        hoverColor: Colors.blue[1000],
                                        hoverElevation: 40.0,
                                        onPressed: () {
                                          uploadmultipleimage();
                                        })),
                              ])))))),
    );
  }

  _giveData(TextEditingController textEditingController) {
    msg = _textEditingController2.text;
    kmvalue = _textEditingController.text;
  }

  Future<void> pickImages() async {
    /*List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: imagesList,
        materialOptions: MaterialOptions(
          actionBarTitle: "AYT ATTENDANCE",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      imagesList = resultList;
      //print("Selected Images---> " + imagesList.join(All_API().baseurl_img));
    });*/
    //File image;
    var imagePicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = imagePicker;
    });
  }
}