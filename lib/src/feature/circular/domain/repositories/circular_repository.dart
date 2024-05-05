import '../../../shared/domain/entities/response_entity.dart';

abstract class CircularRepository {
  Future<ResponseEntity> getCirculars();
  Future<ResponseEntity> getCircularDetails(int circularId);
}
