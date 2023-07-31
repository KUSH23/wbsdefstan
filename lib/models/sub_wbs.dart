import 'package:wbsessential/models/wbs_main.dart';

class WbsSubDataModel {
  final num id;
  final WbsMainDataModel mgroup_name;
  final String msgroup_name;
  final num dserialid;
  final String slug;
  final String description;

  WbsSubDataModel({required this.id, required this.mgroup_name, required this.msgroup_name,
    required this.dserialid, required this.slug, required this.description});

  factory WbsSubDataModel.fromJson(Map<dynamic, dynamic> json) => WbsSubDataModel(
    id: json["id"],
    mgroup_name: WbsMainDataModel.fromJson(json['mgroup_name']),
    msgroup_name: json["msgroup_name"],
    dserialid: json["dserialid"],
    slug: json["slug"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "mgroup_name": mgroup_name,
    "msgroup_name": msgroup_name,
    "dserialid": dserialid,
    "slug": slug,
    "description": description,
  };
}
