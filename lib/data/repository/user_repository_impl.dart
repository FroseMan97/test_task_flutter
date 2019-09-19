import 'package:test_task_flutter/data/datasource/remote_datasource.dart';
import 'package:test_task_flutter/data/mapper/user_mapper.dart';
import 'package:test_task_flutter/domain/entity/user_entity.dart';
import 'package:test_task_flutter/domain/repository/user_repository.dart';

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
