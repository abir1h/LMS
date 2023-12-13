class ImageAssets {
  const ImageAssets._();

  //:::::::::::::::::: IMAGE SETS ::::::::::::::::::
  static String get imgEmptyProfile => 'user_profile'.png;
  static String get icLogo => 'Hero_logo'.png;
  static String get imgPlaceholder => 'placeholder'.png;

  static String get imgModule1 => 'Illustrator_Module_1'.png;
  static String get imgModule2 => 'Illustrator_Module_2'.png;
  static String get imgModule3 => 'Illustrator_Module_3'.png;
  static String get imgModule4 => 'Illustrator_Module_4'.png;

  static String get imgTraineeCard1 => 'trainee_card'.svg;
  static String get imgTraineeCard2 => 'trainee_card2'.svg;
  static String get imgTraineeCard3 => 'trainee_card3'.svg;
  static String get imgTraineeCard4 => 'trainee_card4'.svg;
  static String get imgRunningCourse => 'running_course'.svg;
  static String get notes => 'Notes'.svg;
  static String get home => 'home'.svg;
  static String get courses => 'Courses'.svg;
  static String get profile => 'Profile'.svg;
  static String get icBook => 'book'.svg;
  static String get icSocialLearning => 'social_learning'.svg;
  static String get icLockOpenRight => 'lock_open_right'.svg;
  static String get downloadIcon => 'download'.svg;
  static String get icEdit => 'edit'.svg;
  static String get icEditorChoice => 'editor_choice'.svg;
  static String get icEditSquare => 'edit_square'.svg;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get svg => 'assets/images/icons/$this.svg';
}
