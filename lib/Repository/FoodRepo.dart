import 'dart:async';
import 'dart:convert';
import 'package:foodapp/Model/FoodModel.dart';
import 'package:foodapp/Utils/BaseUrl.dart';
import 'package:http/http.dart' as http;

class FoodRepo {
  Future<List<FoodModel>> getData(String category, String search) async {
    String _url = BaseUrl.meals() + category;

    search == ""
        ? _url = BaseUrl.meals() + category
        : _url = BaseUrl.search() + search;

    print("url :: " + _url);
    final response = await http.get(_url);

    if (response.statusCode == 200)
      return jsonParse(response.body);
    else
      throw Exception();
  }

  List<FoodModel> jsonParse(final response) {
    final json = jsonDecode(response);
    final data = json['meals'];
    print("response data : " + data.toString());
    return new List<FoodModel>.from(data.map((x) => FoodModel.fromJson(x)));
  }
}