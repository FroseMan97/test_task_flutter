import 'package:itgro_test/data/datasource/remote_datasource.dart';
import 'package:itgro_test/data/mapper/user_mapper.dart';
import 'package:itgro_test/domain/entity/user_entity.dart';
import 'package:itgro_test/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  RemoteDatasource _remoteDatasource;
  UserMapper _userMapper;

  UserRepositoryImpl(this._remoteDatasource,this._userMapper);

  @override
  Future<List<UserEntity>> getUsers(int quantity) async {
    return _userMapper
        .mapModelsToEntities(await _remoteDatasource.getUsers(quantity));
  }
}
