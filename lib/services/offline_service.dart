import 'package:labon_apps/models/trivia_question.dart';

class OfflineQuestionBank {
  static final List<TriviaQuestion> _questions = [
    TriviaQuestion(
      id: 'offline_1',
      question: 'What is the capital of Japan?',
      correctAnswer: 'Tokyo',
      incorrectAnswers: ['Osaka', 'Kyoto', 'Hiroshima'],
      category: 'Geography',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_2',
      question: 'Which planet is known as the Red Planet?',
      correctAnswer: 'Mars',
      incorrectAnswers: ['Venus', 'Jupiter', 'Mercury'],
      category: 'Science & Nature',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_3',
      question: 'What is the largest ocean on Earth?',
      correctAnswer: 'Pacific Ocean',
      incorrectAnswers: ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean'],
      category: 'Geography',
      difficulty: 'medium',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_4',
      question: 'Who wrote Romeo and Juliet?',
      correctAnswer: 'William Shakespeare',
      incorrectAnswers: ['Charles Dickens', 'Jane Austen', 'Mark Twain'],
      category: 'Entertainment: Books',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_5',
      question: 'What is the chemical symbol for gold?',
      correctAnswer: 'Au',
      incorrectAnswers: ['Ag', 'Fe', 'Pb'],
      category: 'Science & Nature',
      difficulty: 'medium',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_6',
      question: 'Which animal is known as the "King of the Jungle"?',
      correctAnswer: 'Lion',
      incorrectAnswers: ['Tiger', 'Bear', 'Elephant'],
      category: 'Animals',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_7',
      question: 'What year did World War II end?',
      correctAnswer: '1945',
      incorrectAnswers: ['1939', '1941', '1950'],
      category: 'History',
      difficulty: 'medium',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_8',
      question: 'What is the hardest natural substance on Earth?',
      correctAnswer: 'Diamond',
      incorrectAnswers: ['Gold', 'Iron', 'Platinum'],
      category: 'Science & Nature',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_9',
      question: 'Which instrument has 88 keys?',
      correctAnswer: 'Piano',
      incorrectAnswers: ['Guitar', 'Violin', 'Drums'],
      category: 'Entertainment: Music',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_10',
      question: 'What is the largest mammal in the world?',
      correctAnswer: 'Blue Whale',
      incorrectAnswers: ['Elephant', 'Giraffe', 'Hippo'],
      category: 'Animals',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_11',
      question: 'Which programming language is known as the "language of the web"?',
      correctAnswer: 'JavaScript',
      incorrectAnswers: ['Python', 'Java', 'C++'],
      category: 'Science: Computers',
      difficulty: 'medium',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_12',
      question: 'What is the currency of the United Kingdom?',
      correctAnswer: 'Pound Sterling',
      incorrectAnswers: ['Euro', 'Dollar', 'Franc'],
      category: 'General Knowledge',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_13',
      question: 'Who painted the Mona Lisa?',
      correctAnswer: 'Leonardo da Vinci',
      incorrectAnswers: ['Pablo Picasso', 'Vincent van Gogh', 'Michelangelo'],
      category: 'Art',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_14',
      question: 'What is the smallest country in the world?',
      correctAnswer: 'Vatican City',
      incorrectAnswers: ['Monaco', 'San Marino', 'Liechtenstein'],
      category: 'Geography',
      difficulty: 'medium',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_15',
      question: 'What is the speed of light?',
      correctAnswer: '299,792,458 m/s',
      incorrectAnswers: ['150,000,000 m/s', '400,000,000 m/s', '1,000,000 m/s'],
      category: 'Science & Nature',
      difficulty: 'hard',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_16',
      question: 'Which sport is played at Wimbledon?',
      correctAnswer: 'Tennis',
      incorrectAnswers: ['Golf', 'Cricket', 'Football'],
      category: 'Sports',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_17',
      question: 'What is the largest organ in the human body?',
      correctAnswer: 'Skin',
      incorrectAnswers: ['Liver', 'Heart', 'Brain'],
      category: 'Science & Nature',
      difficulty: 'medium',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_18',
      question: 'Who was the first person to walk on the Moon?',
      correctAnswer: 'Neil Armstrong',
      incorrectAnswers: ['Buzz Aldrin', 'John Glenn', 'Yuri Gagarin'],
      category: 'History',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_19',
      question: 'What is the main ingredient in guacamole?',
      correctAnswer: 'Avocado',
      incorrectAnswers: ['Tomato', 'Lime', 'Onion'],
      category: 'General Knowledge',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_20',
      question: 'Which element has the atomic number 1?',
      correctAnswer: 'Hydrogen',
      incorrectAnswers: ['Helium', 'Oxygen', 'Carbon'],
      category: 'Science & Nature',
      difficulty: 'medium',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_21',
      question: 'What is the tallest mountain in the world?',
      correctAnswer: 'Mount Everest',
      incorrectAnswers: ['K2', 'Kangchenjunga', 'Makalu'],
      category: 'Geography',
      difficulty: 'easy',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_22',
      question: 'In what year was the first iPhone released?',
      correctAnswer: '2007',
      incorrectAnswers: ['2005', '2008', '2010'],
      category: 'Science: Gadgets',
      difficulty: 'medium',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_23',
      question: 'What is the largest desert in the world?',
      correctAnswer: 'Antarctic Desert',
      incorrectAnswers: ['Sahara Desert', 'Arabian Desert', 'Gobi Desert'],
      category: 'Geography',
      difficulty: 'hard',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_24',
      question: 'Who discovered penicillin?',
      correctAnswer: 'Alexander Fleming',
      incorrectAnswers: ['Louis Pasteur', 'Joseph Lister', 'Robert Koch'],
      category: 'History',
      difficulty: 'medium',
      type: 'multiple',
    ),
    TriviaQuestion(
      id: 'offline_25',
      question: 'What is the national animal of Australia?',
      correctAnswer: 'Red Kangaroo',
      incorrectAnswers: ['Koala', 'Emu', 'Platypus'],
      category: 'Animals',
      difficulty: 'medium',
      type: 'multiple',
    ),
  ];

  static int _currentIndex = 0;

  static void resetIndex() {
    _currentIndex = 0;
  }

  static TriviaQuestion getNextQuestion() {
    if (_currentIndex >= _questions.length) {
      _currentIndex = 0;
    }
    final question = _questions[_currentIndex];
    _currentIndex++;
    return question;
  }

  static List<TriviaQuestion> getRandomQuestions(int count) {
    final shuffled = List<TriviaQuestion>.from(_questions)..shuffle();
    return shuffled.take(count).toList();
  }

  static List<TriviaQuestion> getAllQuestions() {
    return List.from(_questions);
  }

  static int getQuestionCount() {
    return _questions.length;
  }
}
