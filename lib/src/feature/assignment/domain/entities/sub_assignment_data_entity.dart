import 'assignment_submission_data_entity.dart';

class SubAssignmentDataEntity {
  final int id;
  final int circularAssignmentsId;
  final int parentId;
  final String traineesIds;
  final String titleEn;
  final String titleBn;
  final String instructionsEn;
  final String instructionsBn;
  final String supportingDoc;
  final int status;
  final String createdAt;
  final String updatedAt;
  final AssignmentSubmissionDataEntity? assignmentSubmissions;

  SubAssignmentDataEntity({
    required this.id,
    required this.circularAssignmentsId,
    required this.parentId,
    required this.traineesIds,
    required this.titleEn,
    required this.titleBn,
    required this.instructionsEn,
    required this.instructionsBn,
    required this.supportingDoc,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.assignmentSubmissions,
  });
}
