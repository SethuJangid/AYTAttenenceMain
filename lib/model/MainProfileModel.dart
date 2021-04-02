import 'dart:convert';

MainProfileModel mainProfileModelFromJson(String str) => MainProfileModel.fromJson(json.decode(str));
String mainProfileModelToJson(MainProfileModel data) => json.encode(data.toJson());

class MainProfileModel {
  MainProfileModel({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory MainProfileModel.fromJson(Map<String, dynamic> json) => MainProfileModel(
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
    this.id,
    this.uniqueId,
    this.userUniqueId,
    this.username,
    this.password,
    this.name,
    this.email,
    this.phone,
    this.dob,
    this.joiningDate,
    this.departmentId,
    this.designationId,
    this.shiftId,
    this.otp,
    this.role,
    this.profile,
    this.image,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.document,
    this.salary,
    this.adharNo,
    this.altPhoneNo,
    this.spacialEmployee,
    this.date,
    this.status,
    this.deleted,
    this.createdBy,
    this.masterdistributor,
    this.distributor,
    this.retailer,
    this.subadmin,
    this.userType,
    this.fcmId,
    this.deviceId,
  });

  String id;
  String uniqueId;
  String userUniqueId;
  String username;
  String password;
  String name;
  String email;
  String phone;
  DateTime dob;
  DateTime joiningDate;
  String departmentId;
  String designationId;
  String shiftId;
  String otp;
  String role;
  String profile;
  String image;
  String address;
  String city;
  String state;
  String country;
  String pincode;
  String document;
  String salary;
  dynamic adharNo;
  dynamic altPhoneNo;
  String spacialEmployee;
  DateTime date;
  String status;
  String deleted;
  String createdBy;
  String masterdistributor;
  String distributor;
  String retailer;
  String subadmin;
  String userType;
  String fcmId;
  String deviceId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    uniqueId: json["unique_id"],
    userUniqueId: json["user_unique_id"],
    username: json["username"],
    password: json["password"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    dob: DateTime.parse(json["dob"]),
    joiningDate: DateTime.parse(json["joining_date"]),
    departmentId: json["department_id"],
    designationId: json["designation_id"],
    shiftId: json["shift_id"],
    otp: json["otp"],
    role: json["role"],
    profile: json["profile"],
    image: json["image"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
    document: json["document"],
    salary: json["salary"],
    adharNo: json["adhar_no"],
    altPhoneNo: json["alt_phone_no"],
    spacialEmployee: json["spacial_employee"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    deleted: json["deleted"],
    createdBy: json["created_by"],
    masterdistributor: json["masterdistributor"],
    distributor: json["distributor"],
    retailer: json["retailer"],
    subadmin: json["subadmin"],
    userType: json["user_type"],
    fcmId: json["fcm_id"],
    deviceId: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unique_id": uniqueId,
    "user_unique_id": userUniqueId,
    "username": username,
    "password": password,
    "name": name,
    "email": email,
    "phone": phone,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "joining_date": "${joiningDate.year.toString().padLeft(4, '0')}-${joiningDate.month.toString().padLeft(2, '0')}-${joiningDate.day.toString().padLeft(2, '0')}",
    "department_id": departmentId,
    "designation_id": designationId,
    "shift_id": shiftId,
    "otp": otp,
    "role": role,
    "profile": profile,
    "image": image,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "pincode": pincode,
    "document": document,
    "salary": salary,
    "adhar_no": adharNo,
    "alt_phone_no": altPhoneNo,
    "spacial_employee": spacialEmployee,
    "date": date.toIso8601String(),
    "status": status,
    "deleted": deleted,
    "created_by": createdBy,
    "masterdistributor": masterdistributor,
    "distributor": distributor,
    "retailer": retailer,
    "subadmin": subadmin,
    "user_type": userType,
    "fcm_id": fcmId,
    "device_id": deviceId,
  };
}
