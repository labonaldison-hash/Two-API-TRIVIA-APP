const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const dbPath = path.join(__dirname, '../../trivia.db');
const db = new sqlite3.Database(dbPath);

function initDB() {
  db.serialize(() => {
    db.run(`CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL,
      username TEXT UNIQUE NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )`);

    db.run(`CREATE TABLE IF NOT EXISTS questions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      question TEXT NOT NULL,
      correct_answer TEXT NOT NULL,
      incorrect_answers TEXT NOT NULL,
      category TEXT,
      difficulty TEXT,
      type TEXT DEFAULT 'multiple',
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )`);

    db.run(`CREATE TABLE IF NOT EXISTS games (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      score INTEGER DEFAULT 0,
      total_questions INTEGER DEFAULT 15,
      completed BOOLEAN DEFAULT 0,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id)
    )`);

    db.run(`CREATE TABLE IF NOT EXISTS game_answers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      game_id INTEGER,
      question_id INTEGER,
      user_answer TEXT,
      is_correct BOOLEAN,
      FOREIGN KEY (game_id) REFERENCES games(id),
      FOREIGN KEY (question_id) REFERENCES questions(id)
    )`);

    seedQuestions();
  });
}

function seedQuestions() {
  db.get("SELECT COUNT(*) as count FROM questions", (err, row) => {
    if (row.count === 0) {
      const questions = [
        {question: "What is the capital of France?", correct_answer: "Paris", incorrect_answers: JSON.stringify(["London", "Berlin", "Madrid"]), category: "Geography", difficulty: "easy"},
        {question: "Which planet is known as the Red Planet?", correct_answer: "Mars", incorrect_answers: JSON.stringify(["Venus", "Jupiter", "Saturn"]), category: "Science", difficulty: "easy"},
        {question: "What is the largest mammal in the world?", correct_answer: "Blue Whale", incorrect_answers: JSON.stringify(["Elephant", "Giraffe", "Hippo"]), category: "Animals", difficulty: "medium"},
        {question: "In which year did World War II end?", correct_answer: "1945", incorrect_answers: JSON.stringify(["1944", "1946", "1943"]), category: "History", difficulty: "medium"},
        {question: "What is the chemical symbol for gold?", correct_answer: "Au", incorrect_answers: JSON.stringify(["Ag", "Fe", "Cu"]), category: "Science", difficulty: "easy"}
      ];
      
      const stmt = db.prepare(`INSERT INTO questions (question, correct_answer, incorrect_answers, category, difficulty) VALUES (?, ?, ?, ?, ?)`);
      questions.forEach(q => stmt.run(q.question, q.correct_answer, q.incorrect_answers, q.category, q.difficulty));
      stmt.finalize();
      console.log("Questions seeded");
    }
  });
}

module.exports = { db, initDB };
