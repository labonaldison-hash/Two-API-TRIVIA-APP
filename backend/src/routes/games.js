const express = require('express');
const { db } = require('../config/database');

const router = express.Router();

router.post('/start', (req, res) => {
  const { user_id } = req.body;
  
  db.run('INSERT INTO games (user_id, score, total_questions, completed) VALUES (?, 0, 15, 0)',
    [user_id || null], function(err) {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ gameId: this.lastID, message: 'Game started' });
    });
});

router.post('/:gameId/answer', (req, res) => {
  const { gameId } = req.params;
  const { question_id, user_answer, is_correct } = req.body;
  
  db.run('INSERT INTO game_answers (game_id, question_id, user_answer, is_correct) VALUES (?, ?, ?, ?)',
    [gameId, question_id, user_answer, is_correct ? 1 : 0], function(err) {
      if (err) return res.status(500).json({ error: err.message });
      
      if (is_correct) {
        db.run('UPDATE games SET score = score + 1 WHERE id = ?', [gameId]);
      }
      
      res.json({ message: 'Answer recorded' });
    });
});

router.put('/:gameId/complete', (req, res) => {
  const { gameId } = req.params;
  
  db.run('UPDATE games SET completed = 1 WHERE id = ?', [gameId], function(err) {
    if (err) return res.status(500).json({ error: err.message });
    
    db.get('SELECT score FROM games WHERE id = ?', [gameId], (err, game) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: 'Game completed', finalScore: game.score });
    });
  });
});

router.get('/history', (req, res) => {
  const { user_id } = req.query;
  if (!user_id) return res.status(400).json({ error: 'user_id required' });
  
  db.all('SELECT * FROM games WHERE user_id = ? AND completed = 1 ORDER BY created_at DESC LIMIT 20', [user_id], (err, games) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(games);
  });
});

module.exports = router;
