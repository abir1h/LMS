import '../mapper/certificate_data_mapper.dart';
import '../../domain/entities/certificate_data_entity.dart';
import '../mapper/all_progress_data_mapper.dart';
import '../models/all_progress_data_model.dart';
import '../../domain/entities/all_progress_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/remote/profile_data_source.dart';
import '../models/certificate_data_model.dart';


class ProfileRepositoryImp extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImp({required this.profileRemoteDataSource});

  @override
  Future<ResponseEntity> getUserProfileInformation() async {
    ResponseModel responseModel =
        (await profileRemoteDataSource.getUserProfileInformationAction());
    return ResponseModelToEntityMapper<AllProgressDataEntity,
            AllProgressDataModel>()
        .toEntityFromModel(responseModel,
            (AllProgressDataModel model) => model.toAllProgressDataEntity);
  }

  @override
  Future<ResponseEntity> getCertificate() async {
    ResponseModel responseModel =
        (await profileRemoteDataSource.getCertificateAction());
    return ResponseModelToEntityMapper<CertificateDataEntity,
            CertificateDataModel>()
        .toEntityFromModel(responseModel,
            (CertificateDataModel model) => model.toCertificateDataEntity);
  }
}
