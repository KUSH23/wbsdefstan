class WbsMainDataModel {
  final num id;
  final String mgroup_name;
  final num dserialid;
  final String slug;
  final String description;

  WbsMainDataModel({required this.id, required this.mgroup_name,
    required this.dserialid, required this.slug, required this.description});

  factory WbsMainDataModel.fromJson(Map<dynamic, dynamic> json) => WbsMainDataModel(
    id: json["id"],
    mgroup_name: json["mgroup_name"],
    dserialid: json["dserialid"],
    slug: json["slug"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "mgroup_name": mgroup_name,
    "dserialid": dserialid,
    "slug": slug,
    "description": description,
  };
}
