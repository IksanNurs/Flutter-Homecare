class OrderNurseCriteria {
  int? id;
  int? orderid;
  String? key;
  String? value;

  OrderNurseCriteria({
    this.id,
    this.orderid,
    this.key,
    this.value,
  });

  OrderNurseCriteria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderid = json['order_id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    return {
      'id': id,
      'order_id': orderid,
      'key': key,
      'value': value,
    };
  }
}

class UninitializedOrderNurseCriteria extends OrderNurseCriteria {}
