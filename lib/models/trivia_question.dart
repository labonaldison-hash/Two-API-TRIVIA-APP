class TriviaQuestion {
  final String id;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String category;
  final String difficulty;
  final String type;
  final List<String>? tags;

  TriviaQuestion({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.category,
    required this.difficulty,
    required this.type,
    this.tags,
  });

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) {
    return TriviaQuestion(
      id: json['id'] as String,
      question: _decodeHtml(json['question'] as String),
      correctAnswer: _decodeHtml(json['correct_answer'] as String),
      incorrectAnswers: (json['incorrect_answers'] as List)
          .map((e) => _decodeHtml(e as String))
          .toList(),
      category: _decodeHtml(json['category'] as String),
      difficulty: json['difficulty'] as String,
      type: json['type'] as String,
      tags: json['tags'] != null ? (json['tags'] as List).cast<String>() : null,
    );
  }

  static String _decodeHtml(String text) {
    return text
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&#039;', "'")
        .replaceAll('&apos;', "'");
  }
}
