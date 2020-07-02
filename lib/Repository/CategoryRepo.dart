import 'dart:convert';
import 'dart:async';
import 'package:foodapp/Model/CategoryModel.dart';
import 'package:foodapp/Utils/BaseUrl.dart';
import 'package:http/http.dart' as http;

class CategoryRepo{

  Future<List<CategoryModel>> getData() async{
    String _url = BaseUrl.category();

    final response = await http.get(_url);

    if(response.statusCode == 200)
      return jsonParse(response.body);
    else
      throw Exception();

  }

  List<CategoryModel> jsonParse(final response){
    final json = jsonDecode(response);
    final data = json['categories'];
    print("response data : " + data.toString());
    return new List<CategoryModel>.from(data.map((x) => CategoryModel.fromJson(x)));
  }
}