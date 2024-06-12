import '../../domain/entities/user_data_entity.dart';
import '../models/user_data_model.dart';

abstract class UserDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _UserDataModelToEntityMapper
    extends UserDataMapper<UserDataModel, UserDataEntity> {
  @override
  UserDataModel fromEntityToModel(UserDataEntity entity) {
    return UserDataModel(
        id: entity.id,
        username: entity.username,
        name: entity.name,
        designation: entity.designation,
        role: entity.role,
        type: entity.type,
        fcmToken: entity.fcmToken);
  }

  @override
  UserDataEntity toEntityFromModel(UserDataModel model) {
    return UserDataEntity(
        id: model.id,
        username: model.username,
        name: model.name,
        designation: model.designation,
        role: model.role,
        type: model.type,
        fcmToken: model.fcmToken);
  }
}

extension UserDataModelExt on UserDataModel {
  UserDataEntity get toUserDataEntity =>
      _UserDataModelToEntityMapper().toEntityFromModel(this);
}

extension UserDataEntityExt on UserDataEntity {
  UserDataModel get toUserDataModel =>
      _UserDataModelToEntityMapper().fromEntityToModel(this);
}
