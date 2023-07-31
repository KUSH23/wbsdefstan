import 'dart:convert';

import 'package:wbsessential/models/project_items_wbs.dart';
import 'package:wbsessential/models/sub_sub_wbs.dart';

List<WbsNewProjectDataModel> projectFromJson(String str) =>
    List<WbsNewProjectDataModel>.from(json.decode(str).map((x) => WbsNewProjectDataModel.fromJson(x)));
String projectToJson(List<WbsNewProjectDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WbsNewProjectDataModel {
  final num id;
  final String projectid;
  final String project_name;
  final List<WbsNewProjectItemDataModel> project_items;

  WbsNewProjectDataModel({required this.id, required this.projectid, required this.project_name,
    required this.project_items});

  factory WbsNewProjectDataModel.fromJson(Map<dynamic, dynamic> json){
    var project_items_fromJson = json["project_items"] as List;
    List<WbsNewProjectItemDataModel> mssgroup_name_List =
      project_items_fromJson.map((i) => WbsNewProjectItemDataModel.fromJson(i)).toList();
    return WbsNewProjectDataModel(
        id: json["id"],
        projectid: json["projectid"],
        project_name: json["project_name"],
        project_items: mssgroup_name_List,
    );
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "projectid": projectid,
    "project_name": project_name,
    "project_items": project_items,
  };
}

List<WbsNewProjectWDataModel> projectWFromJson(String str) =>
    List<WbsNewProjectWDataModel>.from(json.decode(str).map((x) => WbsNewProjectWDataModel.fromJson(x)));
String projectWToJson(List<WbsNewProjectWDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WbsNewProjectWDataModel {
  final String projectid;
  final String project_name;
  final List<WbsNewProjectItemDataModel> project_items;

  WbsNewProjectWDataModel({required this.projectid, required this.project_name,
    required this.project_items});

  factory WbsNewProjectWDataModel.fromJson(Map<dynamic, dynamic> json){
    // print(json['project_items']);
    var project_items_fromJson = json["project_items"] as List;
    List<WbsNewProjectItemDataModel> mssgroup_name_List =
      project_items_fromJson.map((i) => WbsNewProjectItemDataModel.fromJson(i)).toList();
    return WbsNewProjectWDataModel(
      projectid: json["projectid"],
      project_name: json["project_name"],
      project_items: mssgroup_name_List,
    );
  }

  Map<String, dynamic> toJson() => {
    "projectid": projectid,
    "project_name": project_name,
    "project_items": project_items,
  };
}



