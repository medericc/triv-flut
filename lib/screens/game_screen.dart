import 'package:flutter/material.dart';
import 'package:trivia_chretien/models/game_state.dart';
import 'package:trivia_chretien/screens/result_screen.dart';
import 'package:trivia_chretien/models/question.dart';

class GameScreen extends StatefulWidget {
  final GameState gameState;
  GameScreen({required this.gameState});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int correctAnswers = 0;
  late Question currentQuestion;
  bool showAnswer = false;
  bool isCamembertTurn = false;
  String? camembertTheme;

  @override
  void initState() {
    super.initState();
    currentQuestion = widget.gameState.getRandomQuestions(1).first;
  }

  void showNextTeamDialog() {
  showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => AlertDialog(
    backgroundColor: Color(0xFFF5F5DC), // Couleur personnalisée, OK
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: Colors.brown.shade800,
        width: 2,
      ),
    ),
    title: Text(
      'Équipe suivante : ${widget.gameState.currentTeam.name}',
      style: TextStyle(
        color: Colors.brown.shade900,
        fontFamily: 'Times New Roman',
      ),
    ),
    content: Text(
      'Appuyez sur OK quand vous êtes prêts à poser la question.',
      style: TextStyle(
        color: Colors.brown.shade800,
      ),
    ),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown.shade700, // Remplace `primary`
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
          loadQuestion();
        },
        child: Text(
          'OK',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  ),
);

  }

  void loadQuestion() {
    setState(() {
      showAnswer = false;
      if (isCamembertTurn && camembertTheme != null) {
        currentQuestion = widget.gameState.getQuestionForTheme(camembertTheme!)!;
      } else {
        currentQuestion = widget.gameState.getRandomQuestions(1).first;
      }
    });
  }

  void handleAnswer(bool isCorrect) {
    if (isCorrect) {
      correctAnswers++;
      if (!isCamembertTurn && correctAnswers == 3) {
        showCamembertThemeSelection();
        return;
      } else if (isCamembertTurn) {
        widget.gameState.addThemeToCurrentTeam(camembertTheme!);
        if (widget.gameState.currentTeamHasWon()) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ResultScreen(winner: widget.gameState.currentTeam.name),
            ),
          );
          return;
        }
        resetTurn();
        return;
      }
    } else {
      resetTurn();
      return;
    }
    loadQuestion();
  }

  void resetTurn() {
    setState(() {
      correctAnswers = 0;
      isCamembertTurn = false;
      camembertTheme = null;
    });
    widget.gameState.nextTeam();
    showNextTeamDialog();
  }

  void showCamembertThemeSelection() {
    final availableThemes = widget.gameState.allThemes
        .where((theme) => widget.gameState.isThemeAvailableForCamembert(theme))
        .toList();

   showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => AlertDialog(
    backgroundColor: const Color(0xFFF5F5DC), // Couleur personnalisée inchangée
    title: const Text(
      '🎯 Question Camembert !',
      style: TextStyle(
        color: Colors.brown, // ou mieux : Colors.brown.shade900
        fontSize: 24,
      ),
    ),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: availableThemes.map((theme) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade600, // Remplace `primary`
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  isCamembertTurn = true;
                  camembertTheme = theme;
                });
                loadQuestion();
              },
              child: Text(
                theme,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  ),
);
  }

  Widget buildScoreBoard() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5DC).withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.brown[800]!),
      ),
      child: Column(
        children: widget.gameState.teams.map((team) {
          final isCurrent = team == widget.gameState.currentTeam;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              '${team.name} : ${isCurrent ? correctAnswers : 0}/3, ${team.wonThemes.length} camemberts',
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown[900],
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Times New Roman',
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final team = widget.gameState.currentTeam;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEFE6DD),
              Color(0xFFD2B48C),
              Color(0xFF8B4513),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // En-tête
              Text(
                'Équipe : ${team.name}',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.brown[900],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(height: 20),
              
              // Tableau des scores
              buildScoreBoard(),
              SizedBox(height: 30),
              
              // Conteneur de la question
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5DC).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.brown[800]!),
                    ),
                    child: Column(
                      children: [
                        // Thème
                        Text(
                          'Thème : ${currentQuestion.theme}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.brown[800],
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                        Divider(color: Colors.brown, height: 30),
                        
                        // Question
                        Text(
                          currentQuestion.question,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.brown[900],
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        
                        // Zone réponse/boutons
                        if (!showAnswer)
                         ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.brown.shade700, // Remplace `primary`
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  onPressed: () => setState(() => showAnswer = true),
  child: const Text(
    'RÉVÉLER LA RÉPONSE',
    style: TextStyle(fontSize: 18, color: Colors.white),
  ),
)

                        else ...[
                          // Réponse
                         Container(
  padding: const EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: Colors.brown[50],
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.brown.shade800), // Bord marron foncé
  ),
  child: Text(
    'Réponse : ${currentQuestion.options[currentQuestion.correctIndex]}',
    style: TextStyle(
      fontSize: 20,
      color: Colors.brown.shade900, // Texte marron foncé
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  ),
),
 SizedBox(height: 30),
                          
                          // Boutons de réponse
                         Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Bouton Correct (fond bleu foncé/marron, texte blanc)
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B3B6D), // Bleu foncé/marron
        foregroundColor: Colors.white, // Texte et icône en blanc
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => handleAnswer(true),
      icon: const Icon(Icons.check, size: 28),
      label: const Text('Correct'),
    ),

    // Bouton Incorrect (fond marron foncé orangé, texte blanc)
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8B4000), // Marron foncé orangé
        foregroundColor: Colors.white, // Texte et icône en blanc
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => handleAnswer(false),
      icon: const Icon(Icons.close, size: 28),
      label: const Text('Incorrect'),
    ),
  ],
)
,
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 