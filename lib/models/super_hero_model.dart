import 'package:flutter/foundation.dart';

class SuperheroModel {
  final String name;
  final Map<String, dynamic> powerStats;
  final Map<String, dynamic> biography;
  final String image_url;
  SuperheroModel({this.name, this.powerStats, this.biography, this.image_url});

  factory SuperheroModel.fromJson(Map<String, dynamic> json) {
    return SuperheroModel(
        biography: json['biography'],
        powerStats: json['powerstats'],
        name: json["name"],
        image_url: json['image']);
  }
}
