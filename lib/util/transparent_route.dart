import 'package:flutter/material.dart';

class TransparentPageRoute<T> extends MaterialPageRoute<T> { // закомментировал строку "assert(opaque)" in MaterialPageRoute, чтобы включилась прозрачность
  TransparentPageRoute({
    @required builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(builder: builder, settings: settings, fullscreenDialog: false);

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;
}
