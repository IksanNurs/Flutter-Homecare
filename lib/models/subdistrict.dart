class SubdistrictModel {
  String? id;
  String? districtid;
  String? name;

  SubdistrictModel({
    this.id,
    this.districtid,
    this.name,
  });

  SubdistrictModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtid = json['district_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    return {
      'id': id,
      'district_id': districtid,
      'name': name,
    };
  }
}

class UninitializedSubdistricModel extends SubdistrictModel {}
