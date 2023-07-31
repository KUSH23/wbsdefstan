import 'dart:convert';

import 'package:wbsessential/models/sub_sub_wbs.dart';

List<WbsNewProjectItemDataModel> projectItemFromJson(String str) =>
    List<WbsNewProjectItemDataModel>.from(json.decode(str).map((x) => WbsNewProjectItemDataModel.fromJson(x)));
String projectItemToJson(List<WbsNewProjectItemDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WbsNewProjectItemDataModel {
  final num mssgroup;

  WbsNewProjectItemDataModel({
    required this.mssgroup});

  factory WbsNewProjectItemDataModel.fromJson(Map<dynamic, dynamic> json){
    return WbsNewProjectItemDataModel(
      mssgroup: json["mssgroup"],
    );
  }

  Map<String, dynamic> toJson() => {
    "mssgroup": mssgroup,
  };
}


List<WbsViewProjectItemDataModel> projectItemViewFromJson(String str) =>
    List<WbsViewProjectItemDataModel>.from(json.decode(str).map((x) => WbsViewProjectItemDataModel.fromJson(x)));
String projectItemViewToJson(List<WbsNewProjectItemDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WbsViewProjectItemDataModel {
  final num project;
  final WbsSubSubDataModel mssgroup;

  WbsViewProjectItemDataModel({
    required this.mssgroup, required this.project});

  factory WbsViewProjectItemDataModel.fromJson(Map<dynamic, dynamic> json){
    return WbsViewProjectItemDataModel(
      project: json["project"],
      mssgroup: WbsSubSubDataModel.fromJson(json["mssgroup"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "project" : project,
    "mssgroup": mssgroup,
  };
}