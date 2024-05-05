import 'circular_data_entity.dart';

class AllCircularDataEntity {
  final List<CircularDataEntity> running;
  final List<CircularDataEntity> upcoming;
  final List<CircularDataEntity> completed;

  AllCircularDataEntity({
    required this.running,
    required this.upcoming,
    required this.completed,
  });
}
