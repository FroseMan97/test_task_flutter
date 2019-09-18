import 'package:flutter/material.dart';
import 'package:itgro_test/data/datasource/impl/remote_datasource_impl.dart';
import 'package:itgro_test/data/datasource/remote_datasource.dart';
import 'package:itgro_test/data/mapper/user_mapper.dart';
import 'package:itgro_test/data/repository/user_repository_impl.dart';
import 'package:itgro_test/domain/entity/user_entity.dart';
import 'package:itgro_test/domain/repository/user_repository.dart';
import 'package:itgro_test/domain/usecase/get_users_usecase.dart';
import 'package:itgro_test/presentation/bloc/bloc.dart';
import 'package:itgro_test/presentation/page/detail_page.dart';
import 'package:itgro_test/presentation/widget/error_widget.dart';
import 'package:itgro_test/presentation/widget/loading_widget.dart';
import 'package:itgro_test/util/transparent_route.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Bloc _bloc;
  ScrollController _scrollController;

  @override
  void initState() {
    RemoteDatasource _remoteDatasource = RemoteDatasourceImpl();
    UserMapper _userMapper = UserMapper();
    UserRepository _userRepository =
        UserRepositoryImpl(_remoteDatasource, _userMapper);
    GetUsersUsecase _getUsersUsecase = GetUsersUsecase(_userRepository);
    _bloc = Bloc(_getUsersUsecase);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _bloc.fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<List<UserEntity>>(
          stream: _bloc.getUsers,
          builder: (context, snapshot) {
            if (!_bloc.isCachedListEmpty()) {
              List<UserEntity> list = _bloc.getCachedUsers;
              return ListView.separated(
                controller: _scrollController,
                separatorBuilder: (context, i) => Divider(),
                itemCount: list.length + 1,
                itemBuilder: (context, i) {
                  if (i == list.length) {
                    if (snapshot.hasError) {
                      return ErrorColumnWidget(() => _bloc.fetchUsers());
                    }
                    return LoadingWidget();
                  } else {
                    UserEntity user = list[i];
                    return _buildTile(user, i);
                  }
                },
              );
            }
            if (snapshot.hasError) {
              return ErrorColumnWidget(() => _bloc.fetchUsers());
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }

  _buildTile(UserEntity user, int index) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            TransparentPageRoute(
                builder: (BuildContext context) => DetailPage(_bloc, index)));
      },
      leading: Image.network(user.getSmallPicture),
      title: Text(user.getFullName),
      subtitle: Text(user.getFullAddress),
    );
  }
}
