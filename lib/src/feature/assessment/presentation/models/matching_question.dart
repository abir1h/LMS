class MatchingQuestions {
  List<MatchingLeftSide> leftSides;
  List<MatchingRightSide> rightSides;
  MatchingQuestions({
    required this.leftSides,
    required this.rightSides,
  });
}

class MatchingLeftSide {
  int id;
  String leftSide;
  MatchingRightSide selectedRightSide;
  double mark;

  MatchingLeftSide({
    required this.id,
    required this.leftSide,
    required this.selectedRightSide,
    required this.mark,
  });
}

class MatchingRightSide {
  int index;
  bool isUsed;
  String rightSideText;

  MatchingRightSide({
    this.index = -1,
    this.isUsed = false,
    this.rightSideText = "",
  });
}
