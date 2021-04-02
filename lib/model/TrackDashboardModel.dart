// To parse this JSON data, do
//
//     final trackDashboardModel = trackDashboardModelFromJson(jsonString);

import 'dart:convert';

TrackDashboardModel trackDashboardModelFromJson(String str) => TrackDashboardModel.fromJson(json.decode(str));

String trackDashboardModelToJson(TrackDashboardModel data) => json.encode(data.toJson());

class TrackDashboardModel {
  TrackDashboardModel({
    this.status,
    this.msg,
    this.path,
    this.device,
    this.data,
  });

  bool status;
  String msg;
  String path;
  int device;
  List<Datum> data;

  factory TrackDashboardModel.fromJson(Map<String, dynamic> json) => TrackDashboardModel(
    status: json["status"],
    msg: json["msg"],
    path: json["path"],
    device: json["device"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "path": path,
    "device": device,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.employeeRecord,
    this.counterRecord,
    this.locationRecord,
    this.workRecord,
    this.attendanceRecord,
  });

  List<EmployeeRecord> employeeRecord;
  List<CounterRecord> counterRecord;
  List<LocationRecord> locationRecord;
  List<WorkRecord> workRecord;
  List<AttendanceRecord> attendanceRecord;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    employeeRecord: List<EmployeeRecord>.from(json["employeeRecord"].map((x) => EmployeeRecord.fromJson(x))),
    counterRecord: List<CounterRecord>.from(json["counterRecord"].map((x) => CounterRecord.fromJson(x))),
    locationRecord: List<LocationRecord>.from(json["locationRecord"].map((x) => LocationRecord.fromJson(x))),
    workRecord: List<WorkRecord>.from(json["workRecord"].map((x) => WorkRecord.fromJson(x))),
    attendanceRecord: List<AttendanceRecord>.from(json["attendanceRecord"].map((x) => AttendanceRecord.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "employeeRecord": List<dynamic>.from(employeeRecord.map((x) => x.toJson())),
    "counterRecord": List<dynamic>.from(counterRecord.map((x) => x.toJson())),
    "locationRecord": List<dynamic>.from(locationRecord.map((x) => x.toJson())),
    "workRecord": List<dynamic>.from(workRecord.map((x) => x.toJson())),
    "attendanceRecord": List<dynamic>.from(attendanceRecord.map((x) => x.toJson())),
  };
}

class AttendanceRecord {
  AttendanceRecord({
    this.checkinTime,
    this.checkoutTime,
  });

  String checkinTime;
  String checkoutTime;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) => AttendanceRecord(
    checkinTime: json["checkin_time"],
    checkoutTime: json["checkout_time"],
  );

  Map<String, dynamic> toJson() => {
    "checkin_time": checkinTime,
    "checkout_time": checkoutTime,
  };
}

class CounterRecord {
  CounterRecord({
    this.totalLateCheckin,
    this.lateCheckin,
    this.totalEarlyCheckout,
    this.earlyCheckout,
  });

  String totalLateCheckin;
  int lateCheckin;
  String totalEarlyCheckout;
  int earlyCheckout;

  factory CounterRecord.fromJson(Map<String, dynamic> json) => CounterRecord(
    totalLateCheckin: json["total_late_checkin"],
    lateCheckin: json["late_checkin"],
    totalEarlyCheckout: json["total_early_checkout"],
    earlyCheckout: json["early_checkout"],
  );

  Map<String, dynamic> toJson() => {
    "total_late_checkin": totalLateCheckin,
    "late_checkin": lateCheckin,
    "total_early_checkout": totalEarlyCheckout,
    "early_checkout": earlyCheckout,
  };
}

class EmployeeRecord {
  EmployeeRecord({
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
    this.online,
    this.checkinTime,
    this.checkoutTime,
  });

  String id;
  String uniqueId;
  String userUniqueId;
  String username;
  String password;
  String name;
  String email;
  String phone;
  String dob;
  String joiningDate;
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
  String adharNo;
  String altPhoneNo;
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
  String online;
  String checkinTime;
  String checkoutTime;

  factory EmployeeRecord.fromJson(Map<String, dynamic> json) => EmployeeRecord(
    id: json["id"],
    uniqueId: json["unique_id"],
    userUniqueId: json["user_unique_id"],
    username: json["username"],
    password: json["password"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    dob: json["dob"],
    joiningDate: json["joining_date"],
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
    online: json["online"],
    checkinTime: json["checkin_time"],
    checkoutTime: json["checkout_time"],
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
    "dob": dob,
    "joining_date": joiningDate,
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
    "online": online,
    "checkin_time": checkinTime,
    "checkout_time": checkoutTime,
  };
}

class LocationRecord {
  LocationRecord({
    this.accuracyPer,
    this.accuracyMeter,
  });

  String accuracyPer;
  String accuracyMeter;

  factory LocationRecord.fromJson(Map<String, dynamic> json) => LocationRecord(
    accuracyPer: json["accuracy_per"],
    accuracyMeter: json["accuracy_meter"],
  );

  Map<String, dynamic> toJson() => {
    "accuracy_per": accuracyPer,
    "accuracy_meter": accuracyMeter,
  };
}

class WorkRecord {
  WorkRecord({
    this.totalWorkingHours,
    this.employeeWorkingHours,
    this.differenceTime,
  });

  String totalWorkingHours;
  String employeeWorkingHours;
  String differenceTime;

  factory WorkRecord.fromJson(Map<String, dynamic> json) => WorkRecord(
    totalWorkingHours: json["total_working_hours"],
    employeeWorkingHours: json["employee_working_hours"],
    differenceTime: json["difference_time"],
  );

  Map<String, dynamic> toJson() => {
    "total_working_hours": totalWorkingHours,
    "employee_working_hours": employeeWorkingHours,
    "difference_time": differenceTime,
  };
}
