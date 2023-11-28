import '../../domain/entities/profile_data_entity.dart';
import '../models/profile_data_model.dart';

abstract class ProfileDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ProfileDataModelToEntityMapper
    extends ProfileDataMapper<ProfileDataModel, ProfileDataEntity> {
  @override
  ProfileDataModel fromEntityToModel(ProfileDataEntity entity) {
    return ProfileDataModel(
      name: entity.name,
      email: entity.email,
      profileImage: entity.profileImage,
      pdsId: entity.pdsId,
      designation: entity.designation,
      subject: entity.subject,
      institution: entity.institution,
      mobile: entity.mobile,
      zila: entity.zila,
      type: entity.type,
    );
  }

  @override
  ProfileDataEntity toEntityFromModel(ProfileDataModel model) {
    return ProfileDataEntity(
        name: model.name,
        email: model.email,
        profileImage: model.profileImage,
        pdsId: model.pdsId,
        designation: model.designation,
        subject: model.subject,
        institution: model.institution,
        mobile: model.mobile,
        zila: model.zila,
        type: model.type);
  }
}

extension ProfileDataModelExt on ProfileDataModel {
  ProfileDataEntity get toProfileDataEntity =>
      _ProfileDataModelToEntityMapper().toEntityFromModel(this);
}

extension ProfileDataEntityExt on ProfileDataEntity {
  ProfileDataModel get toProfileDataModel =>
      _ProfileDataModelToEntityMapper().fromEntityToModel(this);
}
