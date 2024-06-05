import 'assignment_submission_data_entity.dart';
import 'sub_assignment_data_entity.dart';
import 'submitted_trainee_list_data_entity.dart';

class AssignmentDataEntity {
  final int id;
  final int courseId;
  final int circularId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final int mark;
  final int passMark;
  final int totalTime;
  final String submissionType;
  final String extendedDueDate;
  final String assignmentStartTime;
  final String assignmentEndTime;
  final String descriptionEn;
  final String descriptionBn;
  final String instructionsEn;
  final String instructionsBn;
  final String type;
  final String supportingDoc;
  final int assignmentRequestCount;
  final bool inReview;
  final bool allowed;
  final List<SubmittedTraineeListDataEntity> submittedTraineeList;
  final SubAssignmentDataEntity? circularSubAssignments;
  final AssignmentSubmissionDataEntity? assignmentSubmissions;

  AssignmentDataEntity({
    required this.id,
    required this.courseId,
    required this.circularId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.mark,
    required this.passMark,
    required this.totalTime,
    required this.submissionType,
    required this.extendedDueDate,
    required this.assignmentStartTime,
    required this.assignmentEndTime,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.instructionsEn,
    required this.instructionsBn,
    required this.type,
    required this.supportingDoc,
    required this.assignmentRequestCount,
    required this.inReview,
    required this.allowed,
    required this.submittedTraineeList,
    required this.circularSubAssignments,
    required this.assignmentSubmissions,
  });
}
