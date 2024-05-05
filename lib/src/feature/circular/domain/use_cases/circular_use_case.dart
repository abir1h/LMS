import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/circular_repository.dart';

class CircularUseCase {
  final CircularRepository _circularRepository;
  CircularUseCase({required CircularRepository circularRepository})
      : _circularRepository = circularRepository;

  Future<ResponseEntity> getCircularsUseCase() async {
    final response = _circularRepository.getCirculars();
    return response;
  }

  Future<ResponseEntity> getCircularDetailsUseCase(int circularId) async {
    final response = _circularRepository.getCircularDetails(circularId);
    return response;
  }
}
