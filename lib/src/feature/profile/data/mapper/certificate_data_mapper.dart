import '../../domain/entities/certificate_data_entity.dart';
import '../models/certificate_data_model.dart';

abstract class CertificateDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CertificateDataModelToEntityMapper
    extends CertificateDataMapper<CertificateDataModel, CertificateDataEntity> {
  @override
  CertificateDataModel fromEntityToModel(CertificateDataEntity entity) {
    return CertificateDataModel(
      courseNameEn: entity.courseNameEn,
      courseNameBn: entity.courseNameBn,
      courseProgress: entity.courseProgress,
      certificateUrl: entity.certificateUrl,
    );
  }

  @override
  CertificateDataEntity toEntityFromModel(CertificateDataModel model) {
    return CertificateDataEntity(
      courseNameEn: model.courseNameEn,
      courseNameBn: model.courseNameBn,
      courseProgress: model.courseProgress,
      certificateUrl: model.certificateUrl,
    );
  }
}

extension CertificateDataModelExt on CertificateDataModel {
  CertificateDataEntity get toCertificateDataEntity =>
      _CertificateDataModelToEntityMapper().toEntityFromModel(this);
}

extension CertificateDataEntityExt on CertificateDataEntity {
  CertificateDataModel get toCertificateDataModel =>
      _CertificateDataModelToEntityMapper().fromEntityToModel(this);
}
