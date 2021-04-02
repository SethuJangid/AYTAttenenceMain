
import 'dart:convert';

Departmentmodel departmentmodelFromJson(String str) => Departmentmodel.fromJson(json.decode(str));

String departmentmodelToJson(Departmentmodel data) => json.encode(data.toJson());

class Departmentmodel {
  Departmentmodel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory Departmentmodel.fromJson(Map<String, dynamic> json) => Departmentmodel(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.status,
    this.deleted,
    this.date,
  });

  String id;
  String name;
  String status;
  String deleted;
  DateTime date;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    deleted: json["deleted"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "deleted": deleted,
    "date": date.toIso8601String(),
  };
}