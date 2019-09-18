import 'package:itgro_test/domain/entity/user_entity.dart';
import 'package:itgro_test/domain/repository/user_repository.dart';

class GetUsersUsecase {
  UserRepository _userRepository;

  GetUsersUsecase(this._userRepository);

  Future<List<UserEntity>> call() async {
    return await _userRepository.getUsers(10);
  }
}
