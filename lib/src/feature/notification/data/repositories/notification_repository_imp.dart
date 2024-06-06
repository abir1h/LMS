import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../data_sources/remote/notification_data_source.dart';

class NotificationRepositoryImp extends NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;
  NotificationRepositoryImp({required this.notificationRemoteDataSource});

  @override
  Future<ResponseEntity> updateFCMToken(String token) async {
    ResponseModel responseModel =
        (await notificationRemoteDataSource.updateFCMToken(token));
    return ResponseEntity(
        message: responseModel.message, error: responseModel.error, data: null);
  }
}
