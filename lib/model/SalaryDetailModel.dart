// To parse this JSON data, do
//
//     final salaryDetailModel = salaryDetailModelFromJson(jsonString);

import 'dart:convert';

SalaryDetailModel salaryDetailModelFromJson(String str) => SalaryDetailModel.fromJson(json.decode(str));

String salaryDetailModelToJson(SalaryDetailModel data) => json.encode(data.toJson());

class SalaryDetailModel {
  SalaryDetailModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory SalaryDetailModel.fromJson(Map<String, dynamic> json) => SalaryDetailModel(
    status: json["status"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.name,
    this.designation,
    this.joiningDate,
    this.grossSalary,
    this.perDaySalary,
    this.totalWorkingDays,
    this.number,
    this.totalCredit,
    this.credit,
    this.leave,
    this.deduct,
    this.totalDeduct,
    this.netSalary,
  });

  String name;
  String designation;
  String joiningDate;
  String grossSalary;
  int perDaySalary;
  String totalWorkingDays;
  String number;
  int totalCredit;
  List<Credit> credit;
  int leave;
  List<Credit> deduct;
  int totalDeduct;
  int netSalary;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    designation: json["designation"],
    joiningDate: json["joining_date"],
    grossSalary: json["gross_salary"],
    perDaySalary: json["per_day_salary"],
    totalWorkingDays: json["total_working_days"],
    number: json["number"],
    totalCredit: json["total_credit"],
    credit: List<Credit>.from(json["credit"].map((x) => Credit.fromJson(x))),
    leave: json["leave"],
    deduct: List<Credit>.from(json["deduct"].map((x) => Credit.fromJson(x))),
    totalDeduct: json["total_deduct"],
    netSalary: json["net_salary"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "designation": designation,
    "joining_date": joiningDate,
    "gross_salary": grossSalary,
    "per_day_salary": perDaySalary,
    "total_working_days": totalWorkingDays,
    "number": number,
    "total_credit": totalCredit,
    "credit": List<dynamic>.from(credit.map((x) => x.toJson())),
    "leave": leave,
    "deduct": List<dynamic>.from(deduct.map((x) => x.toJson())),
    "total_deduct": totalDeduct,
    "net_salary": netSalary,
  };
}

class Credit {
  Credit({
    this.name,
    this.value,
  });

  String name;
  int value;

  factory Credit.fromJson(Map<String, dynamic> json) => Credit(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}
