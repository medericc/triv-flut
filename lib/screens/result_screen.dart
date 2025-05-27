import 'package:flutter/material.dart';
import 'package:trivia_biblique/screens/home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String winner;
  ResultScreen({required this.winner});

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
                    color: const Color(0xFFF5F5DC).withAlpha(230), // 230 ≈ 0.9 * 255
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                         color: Colors.brown.withAlpha(128), // 128 ≈ 0.5 * 255
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
                      // Couronne de lauriers
                      Icon(
                        Icons.emoji_events,
                        size: 80,
                        color: Colors.brown[700],
                      ),
                      SizedBox(height: 20),
                      
                      // Titre
                      Text(
                        'VICTOIRE',
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
                      
                      // Message de victoire
                      Text(
                        '$winner a remporté le jeu !',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.brown[800],
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      
                      // Citation biblique aléatoire
                      Text(
                        '"Le vainqueur recevra la couronne de vie" - Apocalypse 2:10',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.brown[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      
                      // Bouton principal
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                          shadowColor: Colors.brown[900],
                          side: BorderSide(
                            color: Colors.brown[900]!,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'REJOUER',
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                          (_) => false,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Signature en bas
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Béni soit le vainqueur',
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