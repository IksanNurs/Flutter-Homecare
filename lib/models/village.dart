class VillagesModel {
  String? id;
  String? subdistrictid;
  String? name;
  int? areatypeid;
  int? isactive;

  VillagesModel(
      {this.id, this.subdistrictid, this.name, this.areatypeid, this.isactive});

  VillagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subdistrictid = json['subdistrict_id'];
    name = json['name'];
    areatypeid = json['area_type_id'];
    isactive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    return {
      'id': id,
      'subdistrict_id': subdistrictid,
      'name': name,
      'area_type_id': areatypeid,
      'is_active': isactive,
    };
  }
}

class UninitializedVillagesModel extends VillagesModel {}
