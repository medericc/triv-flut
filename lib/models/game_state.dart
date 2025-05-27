import 'package:trivia_biblique/models/team.dart';
import 'package:trivia_biblique/models/question.dart';
import 'package:trivia_biblique/data/question_bank.dart';

class GameState {
  final List<Team> teams;
  int currentTeamIndex;

  // Liste globale des thèmes disponibles
  final List<String> allThemes = [
    'Histoire',
    'Sciences',
    'Géographie',
    'Sport',
    'Divertissement',
    'Art & Littérature'
  ];

  // Historique des questions posées (pour éviter répétition)
  final List<Question> askedQuestions = [];

  GameState({required this.teams}) : currentTeamIndex = 0;

  Team get currentTeam => teams[currentTeamIndex];

  void nextTeam() {
    currentTeamIndex = (currentTeamIndex + 1) % teams.length;
  }

  bool isThemeAvailableForCamembert(String theme) {
    return !currentTeam.wonThemes.contains(theme);
  }

  bool currentTeamHasWon() {
    return currentTeam.wonThemes.length == allThemes.length;
  }

  void addThemeToCurrentTeam(String theme) {
    if (isThemeAvailableForCamembert(theme)) {
      currentTeam.wonThemes.add(theme);
    }
  }

  void resetGame() {
    for (var team in teams) {
      team.wonThemes.clear();
    }
    currentTeamIndex = 0;
    askedQuestions.clear();
  }

  // 🟨 3 questions aléatoires toutes catégories confondues (évite répétitions)
  List<Question> getRandomQuestions(int count) {
    final remaining = allQuestions
        .where((q) => !askedQuestions.contains(q))
        .toList()
      ..shuffle();

    final selected = remaining.take(count).toList();
    askedQuestions.addAll(selected);
    return selected;
  }

  // 🟦 1 question d’un thème donné (pour tentative de camembert)
  Question? getQuestionForTheme(String theme) {
    final filtered = allQuestions
        .where((q) => q.theme == theme && !askedQuestions.contains(q))
        .toList()
      ..shuffle();

    if (filtered.isEmpty) return null;

    final question = filtered.first;
    askedQuestions.add(question);
    return question;
  }
}
