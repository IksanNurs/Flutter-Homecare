import '../models/product_model.dart';

class MessageModel {
  String? message;
  int? userId;
  String? userName;
  String? userImg;
  bool? isFromUser;
  ProductModel? product;
  DateTime? createdAt;
  DateTime? updatedAt;

  MessageModel({
    this.message,
    this.userId,
    this.userName,
    this.userImg,
    this.isFromUser,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    userName = json['userName'];
    userImg = json['userImg'];
    isFromUser = json['isFromUser'];
    product = json['product'].isEmpty
        ? UninitializedProductModel()
        : ProductModel.fromJson(json['product']);
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'userName': userName,
      'userImg': userImg,
      'isFromUser': isFromUser,
      'product': product is UninitializedProductModel ? {} : product!.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
