import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import './models/super_hero_model.dart';

String key = '3053435988219043';
String baseUrl = 'https://superheroapi.com/api/';

Future<dynamic> getData() async {
  List<SuperheroModel> superhero = [];

  // final response = await dio.get('https://google.com');
  // print(response.data);
  var jsonResponse;
  var response;
  var url;

  // Api call

  for (int i = 1; i < 25; i++) {
    url = Uri.parse('https://superheroapi.com/api/$key/$i');
    response = await http.get(url);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse['name']);
      print('hye');
      superhero.add(SuperheroModel.fromJson({
        "powerstats": jsonResponse["powerstats"],
        "biography": jsonResponse["biography"],
        "name": jsonResponse['name'],
        "image": jsonResponse["image"]["url"]
      }));
    }
  }

  return superhero;
}

//Search Function,For Getting Particular Hero Details

Future<dynamic> searchResults(String query) async {
  List<SuperheroModel> superhero = [];
  var jsonResponse;
  var response;
  var url;
  url = Uri.parse('https://superheroapi.com/api/$key/search/$query');
  response = await http.get(url);
  if (response.statusCode == 200) {
    jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse['results'][0]['name']);
    print('--');
    for (int i = 0; i < jsonResponse['results'].length; i++)
      superhero.add(SuperheroModel.fromJson({
        "powerstats": jsonResponse['results'][i]["powerstats"],
        "biography": jsonResponse['results'][i]["biography"],
        "name": jsonResponse['results'][i]['name'],
        "image": jsonResponse['results'][i]["image"]["url"]
      }));
  }
  print('----');
  print(superhero[0].name);
  return superhero;
}
