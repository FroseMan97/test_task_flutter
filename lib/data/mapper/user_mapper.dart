import 'package:test_task_flutter/data/models/user_model.dart';
import 'package:test_task_flutter/domain/entity/user_entity.dart';

class UserMapper {
  UserEntity mapModelToEntity(UserModel userModel) {
    UserEntity userEntity;
    if (userModel != null) {
      userEntity = UserEntity(
          userModel.firstName,
          userModel.lastName,
          userModel.street,
          userModel.postCode,
          userModel.city,
          userModel.email,
          userModel.phone,
          userModel.pictureSmall,
          userModel.pictureLarge);
    }
    return userEntity;
  }

  UserModel mapEntityToModel(UserEntity userEntity) {
    UserModel userModel;
    if (userEntity != null) {
      userModel = UserModel(
          userEntity.getFirstName,
          userEntity.getLastName,
          userEntity.getStreet,
          userEntity.getPostCode,
          userEntity.getCity,
          userEntity.getEmail,
          userEntity.getPhone,
          userEntity.getSmallPicture,
          userEntity.getLargePicture);
    }
    return userModel;
  }

  List<UserEntity> mapModelsToEntities(List<UserModel> listOfModels) {
    List<UserEntity> listOfEnties;
    if (listOfModels != null) {
      listOfEnties =
          listOfModels.map((model) => mapModelToEntity(model)).toList();
    }
    return listOfEnties;
  }

  List<UserModel> mapEntitiesToModels(List<UserEntity> listOfEntities) {
    List<UserModel> listOfModels;
    if (listOfEntities != null) {
      listOfModels =
          listOfEntities.map((entity) => mapEntityToModel(entity)).toList();
    }
    return listOfModels;
  }
}
