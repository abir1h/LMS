import '../mapper/profile_response_mapper.dart';
import '../../domain/entities/profile_response_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/remote/profile_data_source.dart';

class ProfileRepositoryImp extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImp({required this.profileRemoteDataSource});

  @override
  Future<ProfileResponseEntity> userProfileInformation() async {
    return (await profileRemoteDataSource.userProfileInformationAction())
        .toProfileResponseEntity;
  }
}
