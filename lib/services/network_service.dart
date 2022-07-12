import 'dart:convert';

import 'package:http/http.dart' as http;
import '/constants/constant.dart';

const Map<String, dynamic> temp = {};

getData(String url, {Map<String, dynamic> params = temp, post = true}) async {
  final result;
  if (post)
    result = await http.post(Uri.parse("${Constant.baseUrl}$url"),
        body: params); //https://covidcough.herokuapp.com/login
  else
    result = await http.get(Uri.parse("${Constant.baseUrl}$url"));

  if (result.statusCode == 200) {
    final data = result.body;
    return jsonDecode(data);
  }
}
