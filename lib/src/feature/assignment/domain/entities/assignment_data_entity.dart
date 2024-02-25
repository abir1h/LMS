class AssignmentDataEntity {
  final int id;
  final int courseId;
  final int courseModuleId;
  final String titleEn;
  final String titleBn;
  final int mark;
  final int passMark;
  final int totalTime;
  final String assignmentStartTime;
  final String assignmentEndTime;
  final String extendedDueDate;
  final String instructionsEn;
  final String instructionsBn;
  final String supportingDoc;
  final String submissionType;
  final bool isGroupAssignments;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deletedAt;

  const AssignmentDataEntity({
    required this.id,
    required this.courseId,
    required this.courseModuleId,
    required this.titleEn,
    required this.titleBn,
    required this.mark,
    required this.passMark,
    required this.totalTime,
    required this.assignmentStartTime,
    required this.assignmentEndTime,
    required this.extendedDueDate,
    required this.instructionsEn,
    required this.instructionsBn,
    required this.supportingDoc,
    required this.submissionType,
    required this.isGroupAssignments,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });}