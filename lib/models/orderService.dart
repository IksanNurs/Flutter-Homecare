import 'package:flutter_application_2/models/product_model.dart';

class OrderServiceModel {
  int? id;
  int? orderid;
  int? serviceid;
  int? price;
  int? quantity;
  String? catatan;
  ProductModel? service;

  OrderServiceModel({
    this.id,
    this.orderid,
    this.serviceid,
    this.price,
    this.quantity,
    this.catatan,
    this.service,
  });

  OrderServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderid = json['order_id'];
    serviceid = json['service_id'];
    price = json['price'];
    quantity = json['quantity'];
    catatan = json['remark'];
    service = json['service'] == null
        ? UninitializedProductModel()
        : ProductModel.fromJson(json['service']);
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    return {
      'id': id,
      'order_id': orderid,
      'service_id': serviceid,
      'price': price,
      'quantity': quantity,
      'remark': catatan,
      'service': service is UninitializedProductModel ? {} : service!.toJson(),
    };
  }
}

class UninitializedOrderServiceModel extends OrderServiceModel {}
