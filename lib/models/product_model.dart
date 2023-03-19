import '../models/category_model.dart';
import '../models/gallery_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? baseunit;
  double? price;
  int? ismultipliable;
  String? description;
  String? icon;

  // CategoryModel? category;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  // List<GalleryModel>? galleries;

  ProductModel({
    this.id,
    this.name,
    this.baseunit,
    this.price,
    this.ismultipliable,
    this.description,
    this.icon,
    // this.category,
    // this.createdAt,
    // this.updatedAt,
    // this.galleries,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    baseunit = json['base_unit'];
    ismultipliable = json['is_multipliable'];
    price = double.parse(json['default_price'].toString());
    description = json['description'];
    icon = json['icon'];
    // category = CategoryModel.fromJson(json['category']);
    // galleries = json['galleries']
    //     .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery))
    //     .toList();
    // createdAt = DateTime.parse(json['created_at']);
    // updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    return {
      'id': id,
      'name': name,
      'base_unit': baseunit,
      'default_price': price,
      'is_multipliable': ismultipliable,
      'description': description,
      'icon': icon
      // 'category': category!.toJson(),
      // 'galleries': galleries!.map((gallery) => gallery.toJson()).toList(),
      // 'created_at': createdAt.toString(),
      // 'updated_at': updatedAt.toString(),
    };
  }
}

class UninitializedProductModel extends ProductModel {}
