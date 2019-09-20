import 'package:test_task_flutter/domain/entity/user_entity.dart';
import 'package:test_task_flutter/domain/usecase/get_users_usecase.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  BehaviorSubject _subject = BehaviorSubject<bool>();
  List<UserEntity> _users = [];
  Stream get getUsers => _subject.stream;
  List<UserEntity> get getCachedUsers => _users;
  GetUsersUsecase _getUsersUsecase;

  Bloc(this._getUsersUsecase) {
    fetchUsers();
  }

  void fetchUsers() async {
    _getUsersUsecase().timeout(Duration(seconds: 10)).then((data) {
      _users.addAll(data);
      _subject.add(true);
    }).catchError((error) {
      print(error.toString());
      _subject.addError(error.toString());
    });
  }

  bool isCachedListEmpty() {
    return _users.isEmpty;
  }

  void dispose() {
    _subject.close();
  }
}
