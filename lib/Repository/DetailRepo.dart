import 'dart:async';
import 'dart:convert';
import 'package:foodapp/Model/DetailModel.dart';
import 'package:foodapp/Utils/BaseUrl.dart';
import 'package:http/http.dart' as http;

class DetailRepo{

  Future<List<DetailModel>> getData(String id) async{
    String _url = BaseUrl.details() + id;

    final response = await http.get(_url);

    if(response.statusCode == 200)
      return jsonParse(response.body);
    else
      throw Exception();
  }

  List<DetailModel> jsonParse(final response){
    final json = jsonDecode(response);
    final data = json['meals'];
    print("response data : " + data.toString());
    return new List<DetailModel>.from(data.map((x) => DetailModel.fromJson(x)));
  }
}