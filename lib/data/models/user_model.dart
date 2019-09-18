class UserModel {
  String firstName;
  String lastName;
  String street;
  String city;
  String email;
  String phone;
  String pictureSmall;
  String pictureLarge;
  String postCode;

  UserModel(
      this.firstName,
      this.lastName,
      this.street,
      this.postCode,
      this.city,
      this.email,
      this.phone,
      this.pictureSmall,
      this.pictureLarge);

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['name']['first'];
    lastName = json['name']['last'];
    postCode = json['location']['postcode']?.toString();
    street = json['location']['street'];
    city = json['location']['city'];
    phone = json['phone'];
    email = json['email'];
    pictureSmall = json['picture']['medium'];
    pictureLarge = json['picture']['large'];
  }
}
