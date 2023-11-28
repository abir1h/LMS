import 'profile_data_mapper.dart';
import '../../domain/entities/profile_response_entity.dart';
import '../models/profile_response_model.dart';

abstract class ProfileResponseMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ProfileResponseModelToEntityMapper
    extends ProfileResponseMapper<ProfileResponseModel, ProfileResponseEntity> {
  @override
  ProfileResponseModel fromEntityToModel(ProfileResponseEntity entity) {
    return ProfileResponseModel(
      message: entity.message,
      data: entity.data?.toProfileDataModel,
      errors: entity.errors,
    );
  }

  @override
  ProfileResponseEntity toEntityFromModel(ProfileResponseModel model) {
    return ProfileResponseEntity(
        message: model.message,
        data: model.data?.toProfileDataEntity,
        errors: model.errors
    );
  }
}

extension ProfileResponseModelExt on ProfileResponseModel {
  ProfileResponseEntity get toProfileResponseEntity =>
      _ProfileResponseModelToEntityMapper().toEntityFromModel(this);
}

extension ProfileResponseEntityExt on ProfileResponseEntity {
  ProfileResponseModel get toProfileResponseModel =>
      _ProfileResponseModelToEntityMapper().fromEntityToModel(this);
}
