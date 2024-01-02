class QuizQuestionEntity {
  List<QuestionsEntity> questions;

  QuizQuestionEntity({required this.questions});
}

class QuestionsEntity {
  int id;
  String questionText;
  String questionImage;
  String option1;
  String option2;
  String option3;
  String option4;
  String option5;
  String option1Image;
  String option2Image;
  String option3Image;
  String option4Image;
  String option5Image;
  bool userAnswer1;
  bool userAnswer2;
  bool userAnswer3;
  bool userAnswer4;
  bool userAnswer5;
  bool answer1;
  bool answer2;
  bool answer3;
  bool answer4;
  bool answer5;

  QuestionsEntity({
    required this.id,
    required this.questionText,
    required this.questionImage,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.option5,
    required this.option1Image,
    required this.option2Image,
    required this.option3Image,
    required this.option4Image,
    required this.option5Image,
    required this.userAnswer1,
    required this.userAnswer2,
    required this.userAnswer3,
    required this.userAnswer4,
    required this.userAnswer5,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.answer5,
  });
}
