import '../../domain/use_cases/profile_use_case.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../shared/domain/entities/response_entity.dart';

class ProfileService {
  ProfileService._();
  static final ProfileUseCase _profileUseCase =
      ProfileUseCase(profileRepository: locator.get());

  static Future<ResponseEntity> getProfileInformation() async {
    return _profileUseCase.userProfileInformationUseCase();
  }
}
