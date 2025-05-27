import 'package:flutter/material.dart';
import 'package:trivia_chretien/screens/setup_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEFE6DD), // Beige clair
              Color(0xFFD2B48C), // Marron sable
              Color(0xFF8B4513), // Marron cuir
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Conteneur style parchemin
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5DC).withOpacity(0.9), // Couleur parchemin
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(0, 5),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.brown[800]!,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Titre principal
                      Text(
                        'TRIVIA BIBLIQUE',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[900],
                          fontFamily: 'Times New Roman',
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      Divider(
                        color: Colors.brown,
                        thickness: 1,
                        height: 30,
                      ),
                      
                      // Icône
                      Icon(
                        Icons.auto_stories,
                        size: 70,
                        color: Colors.brown[700],
                      ),
                      SizedBox(height: 20),
                      
                      // Texte descriptif
                      Text(
                        'Testez votre connaissance\n des Saintes Écritures',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.brown[800],
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      
                      // Bouton principal
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
  onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => SetupScreen()),
  ),
  child: Text(
    'COMMENCER LE JEU',
    style: TextStyle(
      fontSize: 18,
      letterSpacing: 1,
    ),
  ),
)
],
                  ),
                ),
                
                // Signature en bas
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    '« Ta parole est une lampe à mes pieds » - Psaume 119:105',
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