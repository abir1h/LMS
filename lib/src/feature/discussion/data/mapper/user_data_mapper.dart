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
        fullnameEn: entity.fullnameEn,
        fullnameBn: entity.fullnameBn,
        image: entity.image);
  }

  @override
  UserDataEntity toEntityFromModel(UserDataModel model) {
    return UserDataEntity(
        id: model.id,
        fullnameEn: model.fullnameEn,
        fullnameBn: model.fullnameBn,
        image: model.image);
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
