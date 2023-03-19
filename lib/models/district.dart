class DistricModel {
  String? id;
  String? provinceid;
  String? name;
  int? areatypeid;

  DistricModel({
    this.id,
    this.provinceid,
    this.name,
    this.areatypeid,
  });

  DistricModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceid = json['province_id'];
    name = json['name'];
    areatypeid = json['area_type_id'];
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    return {
      'id': id,
      'province_id': provinceid,
      'name': name,
      'area_type_id': areatypeid,
    };
  }
}

class UninitializedDistrictModel extends DistricModel {}
