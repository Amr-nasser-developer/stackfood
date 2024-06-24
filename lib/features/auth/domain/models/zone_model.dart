import 'package:google_maps_flutter/google_maps_flutter.dart';

class ZoneModel {
  int? id;
  String? name;
  Coordinates? coordinates;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? restaurantWiseTopic;
  String? customerWiseTopic;
  String? deliverymanWiseTopic;
  double? minimumShippingCharge;
  double? perKmShippingCharge;
  List<FormatedCoordinates>? formatedCoordinates;

  ZoneModel({
    this.id, this.name, this.coordinates, this.status, this.createdAt, this.updatedAt,
    this.restaurantWiseTopic, this.customerWiseTopic, this.deliverymanWiseTopic, this.minimumShippingCharge,
    this.perKmShippingCharge, this.formatedCoordinates,
  });

  ZoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coordinates = json['coordinates'] != null ? Coordinates.fromJson(json['coordinates']) : null;
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantWiseTopic = json['restaurant_wise_topic'];
    customerWiseTopic = json['customer_wise_topic'];
    deliverymanWiseTopic = json['deliveryman_wise_topic'];
    minimumShippingCharge = json['minimum_shipping_charge'] != null ? json['minimum_shipping_charge'].toDouble() : 0;
    perKmShippingCharge = json['per_km_shipping_charge'] != null ? json['per_km_shipping_charge'].toDouble() : 0;
    if (json['formated_coordinates'] != null) {
      formatedCoordinates = <FormatedCoordinates>[];
      json['formated_coordinates'].forEach((v) { formatedCoordinates!.add(FormatedCoordinates.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['restaurant_wise_topic'] = restaurantWiseTopic;
    data['customer_wise_topic'] = customerWiseTopic;
    data['deliveryman_wise_topic'] = deliverymanWiseTopic;
    data['minimum_shipping_charge'] = minimumShippingCharge;
    data['per_km_shipping_charge'] = perKmShippingCharge;
    if (formatedCoordinates != null) {
      data['formated_coordinates'] = formatedCoordinates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coordinates {
  String? type;
  List<LatLng>? coordinates;

  Coordinates({this.type, this.coordinates});

  Coordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['coordinates'] != null) {
      coordinates = <LatLng>[];
      json['coordinates'][0].forEach((v) {
        coordinates!.add(LatLng(double.parse(v[0].toString()), double.parse(v[1].toString())));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FormatedCoordinates {
  double? lat;
  double? lng;

  FormatedCoordinates({this.lat, this.lng});

  FormatedCoordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
