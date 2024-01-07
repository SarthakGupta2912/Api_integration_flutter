// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<ItemsList> welcomeFromJson(String str) => List<ItemsList>.from(json.decode(str).map((x) => ItemsList.fromJson(x)));

String welcomeToJson(List<ItemsList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemsList {
  int id;
  String name;
  String mobile;

  ItemsList({
    required this.id,
    required this.name,
    required this.mobile,
  });

  factory ItemsList.fromJson(Map<String, dynamic> json) => ItemsList(
    id: json["id"],
    name: json["Name"],
    mobile: json["Mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Name": name,
    "Mobile": mobile,
  };
}
