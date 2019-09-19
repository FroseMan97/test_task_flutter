import 'package:test_task_flutter/data/models/user_model.dart';

abstract class RemoteDatasource{
  Future<List<UserModel>> getUsers(int quantity);
}