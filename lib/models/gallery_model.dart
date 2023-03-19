class GalleryModel {
  int? id;
  String? url;

  GalleryModel({
    this.id,
    this.url,
  });

  GalleryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    return {
      'id': this.id,
      'url': this.url,
    };
  }
}
