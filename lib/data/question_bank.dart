import 'package:trivia_chretien/models/question.dart';

final List<Question> allQuestions = [
  // 🟣 Histoire
  Question(
    question: 'Qui a été le premier président de la Cinquième République en France ?',
    options: ['Charles de Gaulle', 'François Mitterrand', 'Valéry Giscard d’Estaing', 'Napoléon'],
    correctIndex: 0,
    theme: 'Histoire',
  ),
  Question(
    question: 'En quelle année a eu lieu la Révolution française ?',
    options: ['1492', '1789', '1848', '1914'],
    correctIndex: 1,
    theme: 'Histoire',
  ),

  // 🧪 Sciences
  Question(
    question: 'Quelle est la formule chimique de l’eau ?',
    options: ['CO2', 'O2', 'H2O', 'NaCl'],
    correctIndex: 2,
    theme: 'Sciences',
  ),
  Question(
    question: 'Combien de planètes compte notre système solaire ?',
    options: ['7', '8', '9', '10'],
    correctIndex: 1,
    theme: 'Sciences',
  ),

  // 🌍 Géographie
  Question(
    question: 'Quel est le plus grand pays du monde par superficie ?',
    options: ['Canada', 'Chine', 'États-Unis', 'Russie'],
    correctIndex: 3,
    theme: 'Géographie',
  ),
  Question(
    question: 'Quelle est la capitale de l’Australie ?',
    options: ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
    correctIndex: 2,
    theme: 'Géographie',
  ),

  // ⚽ Sport
  Question(
    question: 'Combien de joueurs sur le terrain pour une équipe de football ?',
    options: ['9', '10', '11', '12'],
    correctIndex: 2,
    theme: 'Sport',
  ),
  Question(
    question: 'Quel pays a remporté la Coupe du Monde 2018 ?',
    options: ['Allemagne', 'Brésil', 'France', 'Croatie'],
    correctIndex: 2,
    theme: 'Sport',
  ),

  // 🎬 Divertissement
  Question(
    question: 'Quel film a remporté l’Oscar du Meilleur film en 2020 ?',
    options: ['Joker', '1917', 'Parasite', 'Once Upon a Time in Hollywood'],
    correctIndex: 2,
    theme: 'Divertissement',
  ),
  Question(
    question: 'Quel chanteur est connu pour la chanson \"Shape of You\" ?',
    options: ['Justin Bieber', 'Ed Sheeran', 'Bruno Mars', 'The Weeknd'],
    correctIndex: 1,
    theme: 'Divertissement',
  ),

  // 📚 Art & Littérature
  Question(
    question: 'Qui a écrit \"Les Misérables\" ?',
    options: ['Victor Hugo', 'Émile Zola', 'Albert Camus', 'Molière'],
    correctIndex: 0,
    theme: 'Art & Littérature',
  ),
  Question(
    question: 'Quel peintre a réalisé \"La Nuit étoilée\" ?',
    options: ['Picasso', 'Van Gogh', 'Monet', 'Dali'],
    correctIndex: 1,
    theme: 'Art & Littérature',
  ),
];
