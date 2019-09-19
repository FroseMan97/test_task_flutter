import 'package:test_task_flutter/util/string_util.dart' as helper;

class UserEntity {
  String _firstName;
  String _lastName;
  String _street;
  String _city;
  String _email;
  String _phone;
  String _pictureSmall;
  String _pictureLarge;
  String _postcode;

  UserEntity(
      this._firstName,
      this._lastName,
      this._street,
      this._postcode,
      this._city,
      this._email,
      this._phone,
      this._pictureSmall,
      this._pictureLarge);
      
  String get getFirstName => helper.everyWordToUpperCase(_firstName);
  String get getLastName => helper.everyWordToUpperCase(_lastName);
  String get getFullName => '$getFirstName $getLastName';
  String get getPostCode => _postcode.toString();
  String get getStreet =>  helper.everyWordToUpperCase(_street);
  String get getCity =>  helper.everyWordToUpperCase(_city);
  String get getEmail => _email;
  String get getPhone => _phone;
  String get getSmallPicture => _pictureSmall;
  String get getLargePicture => _pictureLarge;
  String get getFullAddress => '$getStreet, $_postcode $getCity';
}
