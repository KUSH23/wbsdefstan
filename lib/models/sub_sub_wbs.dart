import 'dart:convert';

import 'package:wbsessential/models/sub_wbs.dart';
import 'package:wbsessential/models/wbs_main.dart';

List<WbsSubSubDataModel> postFromJson(dynamic str) =>
    List<WbsSubSubDataModel>.from(json.decode(str).map((x) => WbsSubSubDataModel.fromJson(x)));
String postToJson(List<WbsSubSubDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WbsSubSubDataModel {
  final num id;
  final WbsSubDataModel msgroup_name;
  final String mssgroup_name;
  final num dserialid;
  final String slug;
  final String description;

  WbsSubSubDataModel({required this.id, required this.msgroup_name, required this.mssgroup_name,
    required this.dserialid, required this.slug, required this.description});

  factory WbsSubSubDataModel.fromJson(Map<String, dynamic> json) => WbsSubSubDataModel(
    id: json["id"]??0,
    msgroup_name: WbsSubDataModel.fromJson(json['msgroup_name']),
    dserialid: json["dserialid"],
    mssgroup_name: json["mssgroup_name"],
    slug: json["slug"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "msgroup_name": msgroup_name,
    "mssgroup_name": mssgroup_name,
    "dserialid": dserialid,
    "slug": slug,
    "description": description,
  };
}
