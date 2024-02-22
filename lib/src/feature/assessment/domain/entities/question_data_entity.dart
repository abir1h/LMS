import 'option_data_entity.dart';
import 'qustion_type_data_entity.dart';

class QuestionDataEntity {
  final int id;
  final int courseId;
  final int courseAssessmentId;
  final String question;
  final String questionImg;
  final String supportingNotesEn;
  final String mark;
  final String negativeMark;
  final QuestionTypeDataEntity? questionType;
  final int typeId;
  final List<OptionDataEntity> options;

  QuestionDataEntity({
    required this.id,
    required this.courseId,
    required this.courseAssessmentId,
    required this.question,
    required this.questionImg,
    required this.supportingNotesEn,
    required this.mark,
    required this.negativeMark,
    required this.questionType,
    required this.typeId,
    required this.options,
  });
}
