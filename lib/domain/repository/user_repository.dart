import 'package:itgro_test/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers(int quantity);
}
