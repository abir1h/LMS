import 'package:lms/src/feature/profile/data/mapper/emis_user_data_mapper.dart';

import '../../domain/entities/emis_user_data_entity.dart';
import '../../domain/entities/user_info_data_entity.dart';
import '../models/emis_user_data_model.dart';
import '../models/user_info_data_model.dart';

abstract class UserInfoDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _UserInfoDataModelToEntityMapper
    extends UserInfoDataMapper<UserInfoDataModel, UserInfoDataEntity> {
  @override
  UserInfoDataModel fromEntityToModel(UserInfoDataEntity entity) {
    return UserInfoDataModel(
        id: entity.id,
        pdsId: entity.pdsId,
        createdAt: entity.createdAt,
        updateAt: entity.updateAt,
        deletedAt: entity.deletedAt,
        role: entity.role,
        status: entity.status,
        emisUserDataModel: entity.emisUserDataEntity?.toEmisUserDataModel);
  }

  @override
  UserInfoDataEntity toEntityFromModel(UserInfoDataModel model) {
    return UserInfoDataEntity(
        id: model.id,
        pdsId: model.pdsId,
        createdAt: model.createdAt,
        updateAt: model.updateAt,
        deletedAt: model.deletedAt,
        role: model.role,
        status: model.status,
        emisUserDataEntity: model.emisUserDataModel?.toEmisUserDataEntity);
  }
}

extension UserInfoDataModelExt on UserInfoDataModel {
  UserInfoDataEntity get toUserInfoDataEntity =>
      _UserInfoDataModelToEntityMapper().toEntityFromModel(this);
}

extension UserInfoDataEntityExt on UserInfoDataEntity {
  UserInfoDataModel get toUserInfoDataModel =>
      _UserInfoDataModelToEntityMapper().fromEntityToModel(this);
}
