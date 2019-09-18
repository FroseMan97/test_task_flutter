import 'package:rxdart/rxdart.dart';

class DetailBloc{
  BehaviorSubject _subject = BehaviorSubject<int>();
  Stream get getCurrentPage => _subject.stream;

  void pushPageIndex(int index){
    _subject.add(index);
  }

  void dispose(){
    _subject.close();
  }
}