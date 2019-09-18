import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:itgro_test/domain/entity/user_entity.dart';
import 'package:itgro_test/presentation/bloc/bloc.dart';
import 'package:itgro_test/presentation/bloc/detail_bloc.dart';
import 'package:itgro_test/presentation/widget/error_widget.dart';
import 'package:itgro_test/presentation/widget/loading_widget.dart';

class DetailPage extends StatefulWidget {
  final Bloc _bloc;
  final int _currentPage;
  DetailPage(this._bloc, this._currentPage)
      : assert(_bloc != null, _currentPage != null);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailBloc _detailBloc;

  double _marginCard = 10;
  PageController _pageController;
  @override
  void initState() {
    _detailBloc = DetailBloc();
    _detailBloc.pushPageIndex(widget._currentPage);
    _pageController = PageController(
      initialPage: widget._currentPage,
      viewportFraction: 0.8,
    );
    _pageController.addListener(_pageListener);
    super.initState();
  }

  _pageListener() {
    if (_pageController.offset >= _pageController.position.maxScrollExtent &&
        !_pageController.position.outOfRange) {
      widget._bloc.fetchUsers();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _detailBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        Container(
          child: StreamBuilder<List<UserEntity>>(
              stream: widget._bloc.getUsers,
              builder: (context, snapshot) {
                List<UserEntity> list = widget._bloc.getCachedUsers;
                return Scaffold(
                  appBar: AppBar(
                    actions: <Widget>[
                      IconButton(
                        padding: EdgeInsets.symmetric(horizontal: _marginCard),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      )
                    ],
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    title: StreamBuilder<int>(
                        stream: _detailBloc.getCurrentPage,
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return Text(
                                '${snapshot.data + 1} из ${list.length}');
                          else {
                            return Container();
                          }
                        }),
                    centerTitle: true,
                  ),
                  backgroundColor: Colors.transparent,
                  body: Center(
                      child: Container(
                        child: PageView.builder(
                    onPageChanged: (index) => _detailBloc.pushPageIndex(index),
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length + 1,
                    itemBuilder: (context, i) {
                        if (i == list.length) {
                          if (snapshot.hasError) {
                            return Card(
                              margin: EdgeInsets.symmetric(horizontal: _marginCard),
                              child: ErrorColumnWidget(
                                  () => widget._bloc.fetchUsers()),
                            );
                          }
                          return Card(
                              margin: EdgeInsets.symmetric(horizontal: _marginCard),
                              child: LoadingWidget());
                        } else {
                          UserEntity user = list[i];
                          return _buildTile(user);
                        }
                    },
                  ),
                      )),
                );
              }),
        ),
      ],
    );
  }

  _buildTile(UserEntity user) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: _marginCard),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.network(
              user.getLargePicture,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(
              user.getFullName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Address:'),
            subtitle: Text(user.getFullAddress),
          ),
          ListTile(
            title: Text('Email:'),
            subtitle: Text(user.getEmail),
          ),
          ListTile(
            title: Text('Phone:'),
            subtitle: Text(user.getPhone),
          )
        ],
      ),
    );
  }
}
