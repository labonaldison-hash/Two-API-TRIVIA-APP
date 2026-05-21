import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:labon_apps/models/trivia_question.dart';
import 'package:labon_apps/api/api_service.dart';
import 'package:labon_apps/services/offline_service.dart';

void main() {
  runApp(const QuizApp());
}

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LogoPainter(),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Vibrant quiz-game style radial gradient background
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: const [
          Color(0xFFFFD54F),
          Color(0xFFFF9800),
          Color(0xFFFF6584),
          Color(0xFF9C27B0),
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, bgPaint);

    // Thick white inner circle
    final innerPaint = Paint()
      ..color = Colors.white;
    canvas.drawCircle(center, radius * 0.85, innerPaint);

    // Inner colorful ring border
    final ringPaint = Paint()
      ..shader = SweepGradient(
        colors: const [
          Color(0xFFFF6584),
          Color(0xFFFFD54F),
          Color(0xFF4FC3F7),
          Color(0xFF6C63FF),
          Color(0xFFFF6584),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.85));
    canvas.drawCircle(center, radius * 0.85, ringPaint);

    // White circle again (ring border effect)
    final whiteInner = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius * 0.78, whiteInner);

    // Dotted pattern inside (trivia game style)
    for (int i = 0; i < 20; i++) {
      final angle = (i * 18) * 3.14159 / 180;
      final dotR = radius * 0.65;
      final dotX = center.dx + dotR * cos(angle);
      final dotY = center.dy + dotR * sin(angle);
      canvas.drawCircle(
        Offset(dotX, dotY),
        1.5,
        Paint()..color = const Color(0xFF6C63FF).withValues(alpha:0.2),
      );
    }

    // 3D Text - IICT with trivia game effect
    _draw3DText(canvas, center, radius);

    // Sparkle stars around
    _drawStar(canvas, center + Offset(-radius * 0.55, -radius * 0.45), 4, const Color(0xFFFFD700));
    _drawStar(canvas, center + Offset(radius * 0.55, -radius * 0.4), 4, const Color(0xFF4FC3F7));
    _drawStar(canvas, center + Offset(radius * 0.5, radius * 0.45), 4, const Color(0xFFFF6584));
    _drawStar(canvas, center + Offset(-radius * 0.45, radius * 0.5), 4, const Color(0xFF6C63FF));
  }

  void _draw3DText(Canvas canvas, Offset center, double radius) {
    final textSpan = 'TG';
    final fontSize = radius * 0.38;

    // Layer 1: 3D shadow/depth (dark purple, shifted down-right)
    for (int layer = 4; layer >= 1; layer--) {
      final shadowPainter = TextPainter(
        text: TextSpan(
          text: textSpan,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: const Color(0xFF4A148C).withValues(alpha: 0.15 * layer),
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      shadowPainter.layout();
      shadowPainter.paint(
        canvas,
        Offset(
          center.dx - shadowPainter.width / 2 + layer * 0.8,
          center.dy - shadowPainter.height / 2 + layer * 0.8 - 2,
        ),
      );
    }

    // Layer 2: Thick white outline
    final outlinePainter = TextPainter(
      text: TextSpan(
        text: textSpan,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    outlinePainter.layout();
    outlinePainter.paint(
      canvas,
      Offset(
        center.dx - outlinePainter.width / 2,
        center.dy - outlinePainter.height / 2 - 2,
      ),
    );

    // Layer 3: Gradient text fill (bold colorful)
    final gradientTextPainter = TextPainter(
      text: TextSpan(
        text: textSpan,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          foreground: Paint()
            ..shader = LinearGradient(
              colors: const [Color(0xFF6C63FF), Color(0xFF9C27B0), Color(0xFFFF6584)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(Rect.fromLTWH(0, 0, 200, 30)),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    gradientTextPainter.layout();
    gradientTextPainter.paint(
      canvas,
      Offset(
        center.dx - gradientTextPainter.width / 2,
        center.dy - gradientTextPainter.height / 2 - 2,
      ),
    );

    // Layer 4: Top highlight (white shine on text)
    final highlightPainter = TextPainter(
      text: TextSpan(
        text: textSpan,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          foreground: Paint()
            ..shader = LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.6),
                Colors.white.withValues(alpha: 0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(Rect.fromLTWH(0, 0, 200, 15)),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    highlightPainter.layout();
    highlightPainter.paint(
      canvas,
      Offset(
        center.dx - highlightPainter.width / 2,
        center.dy - highlightPainter.height / 2 - 2,
      ),
    );
  }

  void _drawStar(Canvas canvas, Offset center, int points, Color color) {
    final path = Path();
    for (int i = 0; i < points * 2; i++) {
      final r = i % 2 == 0 ? 6.0 : 2.5;
      final angle = (i * 45) * 3.14159 / 180;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ImageWithOverlays extends StatefulWidget {
  final String imageUrl;
  final String category;
  final bool showHint;
  final VoidCallback onToggleHint;

  const _ImageWithOverlays({
    required this.imageUrl,
    required this.category,
    required this.showHint,
    required this.onToggleHint,
  });

  @override
  State<_ImageWithOverlays> createState() => _ImageWithOverlaysState();
}

class _ImageWithOverlaysState extends State<_ImageWithOverlays> {
  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: ValueKey(widget.imageUrl),
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 250,
          ),
          child: Image.network(
            widget.imageUrl,
            width: double.infinity,
            fit: BoxFit.fitWidth,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _imageLoaded = true;
                    });
                  }
                });
                return child;
              }
              return Container(
                height: 200,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return _OfflineImageWidget(category: widget.category);
            },
          ),
        ),
        if (_imageLoaded) ...[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha:0.7),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: widget.onToggleHint,
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha:0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.showHint ? Icons.lightbulb : Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _OfflineImageWidget extends StatelessWidget {
  final String category;
  const _OfflineImageWidget({required this.category});

  Map<String, List<Color>> _getCategoryColors() {
    return {
      'Geography': const [Color(0xFF2E7D32), Color(0xFF4CAF50), Color(0xFF81C784)],
      'Science & Nature': const [Color(0xFF1565C0), Color(0xFF42A5F5), Color(0xFF90CAF9)],
      'History': const [Color(0xFFE65100), Color(0xFFFF9800), Color(0xFFFFCC80)],
      'Animals': const [Color(0xFF5D4037), Color(0xFF8D6E63), Color(0xFFD7CCC8)],
      'Art': const [Color(0xFFAD1457), Color(0xFFE91E63), Color(0xFFF48FB1)],
      'Sports': const [Color(0xFF1B5E20), Color(0xFF4CAF50), Color(0xFFA5D6A7)],
      'Science: Computers': const [Color(0xFF0D47A1), Color(0xFF2196F3), Color(0xFFBBDEFB)],
      'Entertainment: Music': const [Color(0xFF6A1B9A), Color(0xFF9C27B0), Color(0xFFCE93D8)],
      'Entertainment: Books': const [Color(0xFF3E2723), Color(0xFF5D4037), Color(0xFFA1887F)],
      'Entertainment: Film': const [Color(0xFFB71C1C), Color(0xFFF44336), Color(0xFFEF9A9A)],
      'General Knowledge': const [Color(0xFF4A148C), Color(0xFF7B1FA2), Color(0xFFBA68C8)],
      'Science: Gadgets': const [Color(0xFF01579B), Color(0xFF03A9F4), Color(0xFF81D4FA)],
      'default': const [Color(0xFF6C63FF), Color(0xFF8B85FF), Color(0xFFFF6584)],
    };
  }

  IconData _getCategoryIcon() {
    switch (category.toLowerCase()) {
      case 'geography': return Icons.public;
      case 'science & nature': return Icons.science;
      case 'history': return Icons.history_edu;
      case 'animals': return Icons.pets;
      case 'art': return Icons.palette;
      case 'sports': return Icons.sports;
      case 'science: computers': return Icons.computer;
      case 'entertainment: music': return Icons.music_note;
      case 'entertainment: books': return Icons.menu_book;
      case 'entertainment: film': return Icons.movie;
      case 'science: gadgets': return Icons.devices;
      default: return Icons.quiz;
    }
  }

  String _getCategoryEmoji() {
    switch (category.toLowerCase()) {
      case 'geography': return '🌍';
      case 'science & nature': return '🔬';
      case 'history': return '📜';
      case 'animals': return '🦁';
      case 'art': return '🎨';
      case 'sports': return '⚽';
      case 'science: computers': return '💻';
      case 'entertainment: music': return '🎵';
      case 'entertainment: books': return '📚';
      case 'entertainment: film': return '🎬';
      case 'science: gadgets': return '📱';
      default: return '❓';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getCategoryColors()[category] ?? _getCategoryColors()['default']!;
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(_getCategoryIcon(), size: 120, color: Colors.white),
            ),
          ),
          Positioned(
            top: -20,
            left: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha:0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            right: 50,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha:0.08),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getCategoryEmoji(),
                  style: const TextStyle(fontSize: 60),
                ),
                const SizedBox(height: 8),
                Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6C63FF), Color(0xFF8B85FF), Color(0xFFFF6584)],
              ),
            ),
          ),
          // Decorative circles
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha:0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha:0.08),
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha:0.06),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Logo
                const AppLogo(size: 120),

                const SizedBox(height: 24),

                // Welcome text
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Trivia Game',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Test your knowledge with fun questions!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha:0.85),
                      fontSize: 16,
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // Start button
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const QuizScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF6C63FF),
                        elevation: 8,
                        shadowColor: Colors.black.withValues(alpha:0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Play Now',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, size: 24),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final ApiService _apiService = ApiService();
  
  TriviaQuestion? _currentQuestion;
  List<String> _answers = [];
  int _score = 0;
  int _questionCount = 0;
  bool _gameComplete = false;
  List<TriviaQuestion> _questionPool = [];
  int _currentPoolIndex = 0;
  bool _answered = false;
  String? _selectedAnswer;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isRetrying = false;
  bool _showImageHint = false;
  String? _imageUrl;
  String? _imageKeywords;
  final Set<String> _usedQuestionIds = {};
  final Set<String> _usedImageUrls = {};

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    _questionPool = OfflineQuestionBank.getAllQuestions()..shuffle();
    _currentPoolIndex = 0;
    _score = 0;
    _gameComplete = false;
    _usedQuestionIds.clear();
    _loadQuestion();
  }

  Future<void> _loadQuestion() async {
    if (_isRetrying) return;

    setState(() {
      _isLoading = true;
      _answered = false;
      _selectedAnswer = null;
      _errorMessage = null;
      _isRetrying = true;
    });

    // Automatic retry 3 times bago mag-offline
    for (int i = 0; i < 3; i++) {
      try {
        final data = await _apiService.fetchTriviaQuestions(count: 15).timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw Exception('Connection timed out'),
        );

        final results = data['results'] as List;
        _questionPool = results.map((q) => TriviaQuestion.fromJson(q)).toList()..shuffle();
        _currentPoolIndex = 0;
        _loadQuestionFromPool();
        return;
      } catch (e) {
        if (i == 2) {
          _questionPool = OfflineQuestionBank.getAllQuestions()..shuffle();
          _currentPoolIndex = 0;
          _loadQuestionFromPool();
        } else {
          await Future.delayed(const Duration(seconds: 2));
        }
      }
    }
  }

  void _loadQuestionFromPool() {
    // Find next unused question
    int nextIndex = _currentPoolIndex;
    TriviaQuestion? unusedQuestion;

    while (nextIndex < _questionPool.length) {
      final candidate = _questionPool[nextIndex];
      if (!_usedQuestionIds.contains(candidate.question)) {
        unusedQuestion = candidate;
        break;
      }
      nextIndex++;
    }

    if (unusedQuestion != null) {
      _currentPoolIndex = nextIndex + 1;
      final allAnswers = [
        ...unusedQuestion.incorrectAnswers,
        unusedQuestion.correctAnswer,
      ];
      allAnswers.shuffle(Random());

      setState(() {
        _currentQuestion = unusedQuestion;
        _answers = allAnswers;
        _showImageHint = false;
        _isLoading = false;
        _isRetrying = false;
        _answered = false;
        _selectedAnswer = null;
        _questionCount++;
        _imageUrl = null;
      });

      _loadImageForQuestion(unusedQuestion);
    } else {
      setState(() {
        _gameComplete = true;
      });
    }
  }

  Future<void> _loadImageForQuestion(TriviaQuestion question) async {
    try {
      final url = await _apiService.fetchRandomImageUrl(category: question.category);
      _usedImageUrls.add(url);

      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      setState(() {
        _imageUrl = url;
        _imageKeywords = question.category;
      });
    } catch (e) {
      setState(() {
        _imageUrl = null;
      });
    }
  }

  void _checkAnswer(String answer) {
    if (_answered || _currentQuestion == null) return;

    final isCorrect = answer == _currentQuestion!.correctAnswer;

    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      _usedQuestionIds.add(_currentQuestion!.question);
      if (isCorrect) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    _currentPoolIndex++;
    if (_currentPoolIndex >= 15 || _currentPoolIndex >= _questionPool.length) {
      setState(() {
        _gameComplete = true;
      });
    } else {
      _loadQuestionFromPool();
    }
  }

  Color _getButtonColor(String answer) {
    if (!_answered) return const Color(0xFF6C63FF);
    if (answer == _currentQuestion!.correctAnswer) return Colors.green;
    if (answer == _selectedAnswer) return Colors.red;
    return Colors.grey;
  }

  Widget _buildGameCompleteScreen(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6C63FF), Color(0xFF8B85FF), Color(0xFFFF6584)],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -60,
              left: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha:0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              right: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha:0.08),
                ),
              ),
            ),
            Column(
              children: [
                const Spacer(flex: 1),
                const Text('🏆', style: TextStyle(fontSize: 80)),
                const SizedBox(height: 16),
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You completed the game!',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.85),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Your Score',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_score / 15',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _score >= 12
                            ? '🌟 Excellent!'
                            : _score >= 8
                                ? '👍 Good Job!'
                                : '💪 Keep Practicing!',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        _initGame();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF6C63FF),
                        elevation: 8,
                        shadowColor: Colors.black.withValues(alpha:0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add, size: 24),
                          SizedBox(width: 10),
                          Text(
                            'Next Player',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _gameComplete
          ? null
          : AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLogo(size: 36),
                  const SizedBox(width: 10),
                  const Text(
                    'Trivia App',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              centerTitle: true,
              elevation: 4,
              shadowColor: const Color(0xFF6C63FF).withValues(alpha:0.4),
            ),
      body: _gameComplete
          ? _buildGameCompleteScreen(context)
          : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF6C63FF).withValues(alpha:0.05),
              Colors.white,
            ],
          ),
        ),
        child: _isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Loading next question...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6C63FF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : _errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.wifi_off, size: 50, color: Colors.red),
                              const SizedBox(height: 20),
                              const Text(
                                'Connection Error',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _errorMessage!,
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: _loadQuestion,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Try Again', style: TextStyle(fontSize: 16)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6C63FF),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : _currentQuestion == null
                    ? const Center(child: Text('No question available'))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  const AppLogo(size: 80),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Trivia App',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: const [Color(0xFF6C63FF), Color(0xFFFF6584)],
                                        ).createShader(
                                          const Rect.fromLTWH(0, 0, 200, 30),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6C63FF).withValues(alpha:0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.category, size: 16, color: Color(0xFF6C63FF)),
                                          const SizedBox(width: 6),
                                          Text(
                                            _currentQuestion!.category,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF6C63FF),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6C63FF).withValues(alpha:0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star, size: 18, color: Colors.white),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Question $_questionCount/15',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: _imageUrl == null
                                  ? Container(
                                      height: 180,
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                                      ),
                                    )
                                  : _ImageWithOverlays(
                                      imageUrl: _imageUrl!,
                                      category: _currentQuestion!.category,
                                      showHint: _showImageHint,
                                      onToggleHint: () {
                                        setState(() {
                                          _showImageHint = !_showImageHint;
                                        });
                                      },
                                    ),
                            ),
                            if (_showImageHint && _imageKeywords != null)
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF3E0),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFFFB74D)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.tips_and_updates, color: Color(0xFFFF9800), size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Image shows: ${_imageKeywords!.replaceAll(',', ', ')}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFFE65100),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 20),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF6C63FF).withValues(alpha:0.05),
                                      Colors.white,
                                    ],
                                  ),
                                ),
                                child: Text(
                                  _currentQuestion!.question,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ..._answers.map(
                              (answer) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: ElevatedButton(
                                  onPressed: _answered
                                      ? null
                                      : () => _checkAnswer(answer),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _getButtonColor(answer),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: _answered ? 1 : 4,
                                    shadowColor: _getButtonColor(answer).withValues(alpha:0.4),
                                    disabledBackgroundColor: _getButtonColor(answer).withValues(alpha:0.6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _answered && answer == _currentQuestion!.correctAnswer
                                            ? Icons.check_circle
                                            : _answered && answer == _selectedAnswer
                                                ? Icons.cancel
                                                : Icons.circle_outlined,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          answer,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (_answered)
                              ElevatedButton(
                                onPressed: _nextQuestion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Next Question',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward, size: 20),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
      ),
    );
  }
}
