import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/notification_repository.dart';

class NotificationUseCase {
  final NotificationRepository _notificationRepository;
  NotificationUseCase({required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository;

  Future<ResponseEntity> updateFCMTokenUseCase(String token) async {
    final response = _notificationRepository.updateFCMToken(token);
    return response;
  }
}
