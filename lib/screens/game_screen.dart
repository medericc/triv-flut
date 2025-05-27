import 'package:flutter/material.dart';
import 'package:trivia_biblique/models/game_state.dart';
import 'package:trivia_biblique/screens/result_screen.dart';
import 'package:trivia_biblique/models/question.dart';

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

    if (!isCamembertTurn) {
      // Si ce n'est PAS un tour camembert, on charge une nouvelle question normale
      currentQuestion = widget.gameState.getRandomQuestions(1).first;
    }

    // Sinon : NE RIEN FAIRE → on garde la question camembert déjà définie avant
  });
}


void handleAnswer(bool isCorrect) async {
  if (isCorrect) {
    correctAnswers++;
    if (!isCamembertTurn && correctAnswers == 3) {
      // On récupère la question camembert à l'avance
      final question = widget.gameState.getRandomQuestionForAvailableThemes();

      if (question == null) {
        // Plus de questions disponibles → reset ou fin de jeu
        resetTurn();
        return;
      }

      // On affiche la modale avant la question camembert
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: Color(0xFFF5F5DC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.brown.shade800, width: 2),
          ),
          title: Text(
            'Question Camembert',
            style: TextStyle(
              color: Colors.brown.shade900,
              fontFamily: 'Times New Roman',
            ),
          ),
          content: Text(
            'Thème : ${question.theme}\n\nAppuyez sur OK pour continuer.',
            style: TextStyle(color: Colors.brown.shade800),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );

      // Après fermeture de la modale, on met à jour l'état pour afficher la question camembert
      setState(() {
        isCamembertTurn = true;
        camembertTheme = question.theme;
        currentQuestion = question;
        showAnswer = false;
      });

      return;
    } else if (isCamembertTurn) {
      widget.gameState.addThemeToCurrentTeam(camembertTheme!);
      if (widget.gameState.currentTeamHasWon()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ResultScreen(winner: widget.gameState.currentTeam.name),
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



  Widget buildScoreBoard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
         color: const Color(0xFFF5F5DC).withAlpha(204),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.brown[800]!),
      ),
      child: Column(
        children: widget.gameState.teams.map((team) {
          final isCurrent = team == widget.gameState.currentTeam;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
            '${team.name} : ${isCurrent ? correctAnswers : 0}/3, ${team.wonThemes.length} ${team.wonThemes.length == 1 ? "camembert" : "camemberts"}',
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
    final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

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
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: Column(
            children: [
             SizedBox(height: screenHeight * 0.08),
              // En-tête
               Text(
              'Équipe : ${team.name}',
              style: TextStyle(
                fontSize: screenWidth * 0.08,
                color: Colors.brown[900],
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman',
              ),
              textAlign: TextAlign.center,
            ),
               SizedBox(height: screenHeight * 0.04),
              
            
              
              // Conteneur de la question
             Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5DC).withAlpha(230),
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
    '${currentQuestion.options[currentQuestion.correctIndex]}',
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
      icon: const Icon(Icons.check, size: 28,
  color: Colors.white,),
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
      icon: const Icon(
  Icons.close,
  size: 28,
  color: Colors.white,
),
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
            
              // Tableau des scores (déplacé en bas)
              buildScoreBoard(),
                SizedBox(height: 70),
              
            ],
          ),
        ),
      ),
    );
  }
} 