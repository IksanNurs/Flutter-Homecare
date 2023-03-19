class RequestModel {
  String? message;

  RequestModel({
    this.message,
  });

  RequestModel.fromJson(Map<String?, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;

    return map;
  }
}
