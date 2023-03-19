class OrdersModel {
  int? id;
  int? nurseuserid;
  String? name;
  String? age;

  OrdersModel({
    this.id,
    this.name,
  });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    return {
      'id': id,
      'name': name,
    };
  }
}

class UninitializedSubdistricModel extends OrdersModel {}
