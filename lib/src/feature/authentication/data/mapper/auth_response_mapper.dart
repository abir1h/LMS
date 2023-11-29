import 'auth_data_mapper.dart';

import '../models/auth_response_model.dart';
import '../../domain/entities/auth_response_entity.dart';

abstract class AuthResponseMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _AuthResponseModelToEntityMapper
    extends AuthResponseMapper<AuthResponseModel, AuthResponseEntity> {
  @override
  AuthResponseModel fromEntityToModel(AuthResponseEntity entity) {
    return AuthResponseModel(
      message: entity.message,
      data: entity.data?.toAuthDataModel,
      errors: entity.errors,
    );
  }

  @override
  AuthResponseEntity toEntityFromModel(AuthResponseModel model) {
    return AuthResponseEntity(
        message: model.message,
        data: model.data?.toAuthDataEntity,
        errors: model.errors);
  }
}

extension AuthResponseModelExt on AuthResponseModel {
  AuthResponseEntity get toAuthResponseEntity =>
      _AuthResponseModelToEntityMapper().toEntityFromModel(this);
}

extension AuthResponseEntityExt on AuthResponseEntity {
  AuthResponseModel get toAuthResponseModel =>
      _AuthResponseModelToEntityMapper().fromEntityToModel(this);
}
