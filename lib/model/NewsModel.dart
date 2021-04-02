import 'dart:convert';

Newsmodel newsmodelFromJson(String str) => Newsmodel.fromJson(json.decode(str));
String newsmodelToJson(Newsmodel data) => json.encode(data.toJson());

class Newsmodel {
  Newsmodel({
    this.status,
    this.msg,
    this.path,
    this.data,
  });

  bool status;
  String msg;
  String path;
  List<Datum> data;

  factory Newsmodel.fromJson(Map<String, dynamic> json) => Newsmodel(
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
    this.title,
    this.image,
    this.description,
    this.author,
    this.status,
    this.deleted,
    this.date,
  });

  String id;
  String title;
  String image;
  String description;
  String author;
  String status;
  String deleted;
  DateTime date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
    author: json["author"],
    status: json["status"],
    deleted: json["deleted"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": [image],
    "description": description,
    "author": author,
    "status": status,
    "deleted": deleted,
    "date": date.toIso8601String(),
  };
}
/*

enum Author { ADMIN, EMPTY }

final authorValues = EnumValues({
  "admin": Author.ADMIN,
  "": Author.EMPTY
});

enum Description { CHECK_THIS_NEWS, EMPTY }

final descriptionValues = EnumValues({
  "Check This News": Description.CHECK_THIS_NEWS,
  "": Description.EMPTY
});

enum Image { AC4_E08_C742560738_AC33_B6_FC7_D9_F415_B_JPG, EMPTY }

final imageValues = EnumValues({
  "ac4e08c742560738ac33b6fc7d9f415b.JPG": Image.AC4_E08_C742560738_AC33_B6_FC7_D9_F415_B_JPG,
  "": Image.EMPTY
});

enum Title { NEWS_TITLE, EMPTY }

final titleValues = EnumValues({
  "": Title.EMPTY,
  "NewsTitle": Title.NEWS_TITLE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}*/
