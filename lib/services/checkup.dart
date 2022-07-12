import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '/constants/constant.dart';
import 'database_helper.dart';

class CheckUp {
  Future<String> Upload(File file, String sub_url, {context, id = "1"}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();

    var uri = Uri.parse("${Constant.baseUrl}$sub_url");

    var request = http.MultipartRequest("Post", uri);
    request.fields["id"] = id;
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    var data = await http.Response.fromStream(response);
    print(data.body);
    return data.body;
  }

  Future<String> FlaskUpload(File file, String sub_url,
      {context, id = "1"}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();

    var uri = Uri.parse("${Constant.baseUrlFlask}$sub_url");

    var request = http.MultipartRequest("Post", uri);
    request.fields["id"] = id;
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    var data = await http.Response.fromStream(response);
    print(data.body);
    return data.body;
  }

  asyncFileUpload(String text, File file) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${Constant.baseUrl}prediction1/"));

    request.fields["text_field"] = "text";

    var pic = await http.MultipartFile.fromPath("file", file.path);

    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(String path, String result) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.column1: path,
      DatabaseHelper.column2: result
    };
    final id = await dbHelper.insert(row);
    // print('inserted row id: $id');
    return id;
  }

  Future<List<Map<String, dynamic>>> allResult() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    return allRows;
  }
}
