class NotificationModel {
  int? id;
  Data? data;
  String? createdAt;
  String? updatedAt;

  NotificationModel({this.id, this.data, this.createdAt, this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Data {
  String? title;
  String? description;
  String? image;
  String? type;
  dynamic orderId;
  String? orderStatus;

  Data({this.title, this.description, this.image, this.type, this.orderId, this.orderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    type = json['type'];
    orderId = json['order_id'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['type'] = type;
    data['order_id'] = orderId;
    data['order_status'] = orderStatus;
    return data;
  }
}
