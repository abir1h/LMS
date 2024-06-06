import '../../../shared/domain/entities/response_entity.dart';

abstract class NotificationRepository{
  Future<ResponseEntity> updateFCMToken(String token);
}