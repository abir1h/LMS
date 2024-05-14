import 'qustion_type_data_entity.dart';
import 'option_data_entity.dart';

class QuestionDataEntity {
  final int id;
  final int circularCourseId;
  final int circularId;
  final int parentQuestionId;
  final int circularAssessmentId;
  final String question;
  final String questionImg;
  final String supportingNotesEn;
  final String explanation;
  final String supportingNotesBn;
  final String mark;
  final String negativeMark;
  final int createdBy;
  final QuestionTypeDataEntity? questionType;
  final int typeId;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final List<OptionDataEntity> options;
  String userInput;

  QuestionDataEntity({
    required this.id,
    required this.circularCourseId,
    required this.circularId,
    required this.parentQuestionId,
    required this.circularAssessmentId,
    required this.question,
    required this.questionImg,
    required this.supportingNotesEn,
    required this.explanation,
    required this.supportingNotesBn,
    required this.mark,
    required this.negativeMark,
    required this.createdBy,
    required this.questionType,
    required this.typeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.options,
    required this.userInput,
  });
}
