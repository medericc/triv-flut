class Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String theme;

  Question({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.theme,
  });

  bool isCorrect(int index) => index == correctIndex;
} 