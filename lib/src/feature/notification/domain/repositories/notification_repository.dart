import '../../../shared/domain/entities/response_entity.dart';

abstract class NotificationRepository{
  Future<ResponseEntity> updateFCMToken(String token);
  Future<ResponseEntity> updateUserFCMToken(String eMISUserId, String token);
}