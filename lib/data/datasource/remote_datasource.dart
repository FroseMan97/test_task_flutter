import 'package:itgro_test/data/models/user_model.dart';

abstract class RemoteDatasource{
  Future<List<UserModel>> getUsers(int quantity);
}