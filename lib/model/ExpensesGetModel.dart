

import 'dart:convert';

ExpensesGetModel expensesGetModelFromJson(String str) => ExpensesGetModel.fromJson(json.decode(str));
String expensesGetModelToJson(ExpensesGetModel data) => json.encode(data.toJson());

class ExpensesGetModel {
  ExpensesGetModel({
    this.status,
    this.msg,
    this.path,
    this.data,
  });

  bool status;
  String msg;
  String path;
  List<Datum> data;

  factory ExpensesGetModel.fromJson(Map<String, dynamic> json) => ExpensesGetModel(
    status: json["status"],
    msg: json["msg"],
    path: json["path"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "path": path,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.employeeId,
    this.expenseId,
    this.type,
    this.km,
    this.price,
    this.description,
    this.image,
    this.status,
    this.deleted,
    this.date,
    this.expenseName,
  });

  String id;
  String employeeId;
  String expenseId;
  String type;
  String km;
  String price;
  String description;
  String image;
  String status;
  String deleted;
  DateTime date;
  String expenseName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    employeeId: json["employee_id"],
    expenseId: json["expense_id"],
    type: json["type"],
    km: json["km"],
    price: json["price"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    deleted: json["deleted"],
    date: DateTime.parse(json["date"]),
    expenseName: json["expense_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "expense_id": expenseId,
    "type": type,
    "km": km,
    "price": price,
    "description": description,
    "image": image,
    "status": status,
    "deleted": deleted,
    "date": date.toIso8601String(),
    "expense_name": expenseName,
  };
}
