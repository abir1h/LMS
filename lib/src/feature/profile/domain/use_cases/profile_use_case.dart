import '../entities/profile_response_entity.dart';
import '../repositories/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository _profileRepository;
  ProfileUseCase({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  Future<ProfileResponseEntity> userProfileInformationUseCase() async {
    final response = _profileRepository.userProfileInformation();
    return response;
  }
}
