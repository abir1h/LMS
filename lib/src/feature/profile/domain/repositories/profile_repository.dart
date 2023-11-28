import '../entities/profile_response_entity.dart';

abstract class ProfileRepository{

  Future<ProfileResponseEntity> userProfileInformation();
}