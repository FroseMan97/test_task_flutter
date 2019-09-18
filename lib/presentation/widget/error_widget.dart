import 'package:flutter/material.dart';

class ErrorColumnWidget extends StatelessWidget {

  final Function _callBack;

  ErrorColumnWidget(this._callBack);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Произошла ошибка'),
        FlatButton(
          onPressed: _callBack,
          child: Text('Обновить',style: TextStyle(color: Colors.blue),),
        )
      ],
    );
  }
}