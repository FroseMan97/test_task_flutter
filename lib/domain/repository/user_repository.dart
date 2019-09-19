import 'package:test_task_flutter/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers(int quantity);
}
