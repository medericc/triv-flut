import 'package:flutter/material.dart';
import 'package:trivia_chretien/models/game_state.dart';
import 'package:trivia_chretien/models/team.dart';
import 'package:trivia_chretien/screens/game_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int teamCount = 2;
  final List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    controllers.addAll(List.generate(3, (_) => TextEditingController()));
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Conteneur principal style parchemin
             Container(
  width: MediaQuery.of(context).size.width * 0.9,
  padding: EdgeInsets.all(25),
  decoration: BoxDecoration(
    color: const Color(0xFFF5F5DC).withValues(alpha: 0.9),
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.brown.withValues(alpha: 0.5),
        blurRadius: 10,
        spreadRadius: 3,
        offset: Offset(0, 5),
  ),],
                    border: Border.all(
                      color: Colors.brown[800]!,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Titre
                      Text(
                        'CONFIGURATION',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[900],
                          fontFamily: 'Times New Roman',
                          letterSpacing: 2,
                        ),
                      ),
                      
                      Divider(
                        color: Colors.brown,
                        thickness: 1,
                        height: 30,
                      ),
                      
                      // Icône
                      Icon(
                        Icons.group_add,
                        size: 50,
                        color: Colors.brown[700],
                      ),
                      SizedBox(height: 20),
                      
                      // Sélection du nombre d'équipes
                      Text(
                        'Nombre d\'équipes:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.brown[800],
                        ),
                      ),
                      SizedBox(height: 10),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.brown[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.brown[300]!),
                        ),
                        child: DropdownButton<int>(
                          value: teamCount,
                          dropdownColor: Colors.brown[50],
                          icon: Icon(Icons.arrow_drop_down, color: Colors.brown[800]),
                          underline: SizedBox(),
                          style: TextStyle(
                            color: Colors.brown[900],
                            fontSize: 18,
                          ),
                          onChanged: (value) => setState(() => teamCount = value ?? 2),
                          items: [2, 3].map((n) => DropdownMenuItem(
                            value: n,
                            child: Text('$n équipes', style: TextStyle(fontFamily: 'Times New Roman')),
                          )).toList(),
                        ),
                      ),
                      SizedBox(height: 30),
                      
                      // Champs des noms d'équipes
                      ...List.generate(teamCount, (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                          controller: controllers[i],
                          style: TextStyle(color: Colors.brown[900]),
                          decoration: InputDecoration(
                            labelText: 'Nom de l\'équipe ${i + 1}',
                            labelStyle: TextStyle(color: Colors.brown[700]),
                            filled: true,
                            fillColor: Colors.brown[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.brown[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.brown[700]!),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: 20),
                      
                      // Bouton de démarrage
                  ElevatedButton(
  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.brown[700]),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    elevation: WidgetStateProperty.all(5),
    shadowColor: WidgetStateProperty.all(Colors.brown[900]),
    side: WidgetStateProperty.all(
      BorderSide(
        color: Colors.brown[900]!,
        width: 1,
      ),
    ),
  ),
  child: Text(
    'COMMENCER LE JEU',
    style: TextStyle(
      fontSize: 18,
      letterSpacing: 1,
    ),
  ),
  onPressed: () {
    if (controllers.any((c) => c.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez nommer toutes les équipes'),
          backgroundColor: Colors.brown[700],
        ),
      );
      return;
    }

    final teams = List.generate(teamCount, (i) => Team(controllers[i].text));
    final gameState = GameState(teams: teams);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => GameScreen(gameState: gameState)),
    );
  },
),

                    ],
                  ),
                ),
                
                // Citation en bas
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    '« Là où deux ou trois sont assemblés... » - Matthieu 18:20',
                    style: TextStyle(
                      color: Colors.brown[800],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}