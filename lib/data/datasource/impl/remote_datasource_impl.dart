import 'dart:convert';

import 'package:test_task_flutter/data/datasource/remote_datasource.dart';
import 'package:test_task_flutter/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class RemoteDatasourceImpl implements RemoteDatasource{

  static const _url = 'http://api.randomuser.me/?results=';
  final JsonDecoder _decoder = JsonDecoder();

  @override
  Future<List<UserModel>> getUsers(int quantity) async {
    final String query = '$_url$quantity';
    final response = await http.get(query);
    final jsonBody = response.body;
    final statusCode = response.statusCode;
     if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw Exception("Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    final  listOfDecodedItems = _decoder.convert(jsonBody);
    final List listOfUsers = listOfDecodedItems['results'];
    return listOfUsers.map((user)=>UserModel.fromJson(user)).toList();
  }

}