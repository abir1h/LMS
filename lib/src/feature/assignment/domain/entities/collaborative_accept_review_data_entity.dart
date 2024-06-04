import 'assignment_data_entity.dart';
import 'attachment_data_entity.dart';
import 'collaborative_assignment_result_entity.dart';

class CollaborativeAcceptReviewDataEntity {
  final int id;
  final int circularId;
  final int courseId;
  final int circularAssignmentId;
  final int circularSubAssignmentId;
  final int submittedBy;
  final int evaluatedBy;
  final String ipAddress;
  final String answer;
  final int marks;
  final String remarks;
  final int status;
  final int isResubmitted;
  final String createdAt;
  final String updatedAt;
  final AssignmentDataEntity? assignment;
  final List<AttachmentDataEntity> attachments;
  final CollaborativeAssignmentResultDataEntity? collaborativeAssignmentResult;

  CollaborativeAcceptReviewDataEntity({
    required this.id,
    required this.circularId,
    required this.courseId,
    required this.circularAssignmentId,
    required this.circularSubAssignmentId,
    required this.submittedBy,
    required this.evaluatedBy,
    required this.ipAddress,
    required this.answer,
    required this.marks,
    required this.remarks,
    required this.status,
    required this.isResubmitted,
    required this.createdAt,
    required this.updatedAt,
    required this.assignment,
    required this.attachments,
    required this.collaborativeAssignmentResult,
  });
}
