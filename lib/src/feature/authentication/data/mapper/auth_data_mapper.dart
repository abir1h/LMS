import 'user_data_mapper.dart';
import '../models/auth_data_model.dart';
import '../../domain/entities/auth_data_entity.dart';

abstract class AuthDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _AuthDataModelToEntityMapper
    extends AuthDataMapper<AuthDataModel, AuthDataEntity> {
  @override
  AuthDataModel fromEntityToModel(AuthDataEntity entity) {
    return AuthDataModel(
        user: entity.user.toUserDataModel,
        accessToken: entity.accessToken,
        refreshToken: entity.refreshToken,
        expiresIn: entity.expiresIn,
        policy: entity.policy);
  }

  @override
  AuthDataEntity toEntityFromModel(AuthDataModel model) {
    return AuthDataEntity(
        user: model.user!.toUserDataEntity,
        accessToken: model.accessToken,
        refreshToken: model.refreshToken,
        expiresIn: model.expiresIn,
        policy: model.policy);
  }
}

extension AuthDataModelExt on AuthDataModel {
  AuthDataEntity get toAuthDataEntity =>
      _AuthDataModelToEntityMapper().toEntityFromModel(this);
}

extension AuthDataEntityExt on AuthDataEntity {
  AuthDataModel get toAuthDataModel =>
      _AuthDataModelToEntityMapper().fromEntityToModel(this);
}
