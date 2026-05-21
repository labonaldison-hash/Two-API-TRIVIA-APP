const express = require('express');
const { db } = require('../config/database');

const router = express.Router();

router.get('/global', (req, res) => {
  db.all(`SELECT u.username, g.score, g.created_at 
          FROM games g 
          JOIN users u ON g.user_id = u.id 
          WHERE g.completed = 1 
          ORDER BY g.score DESC, g.created_at ASC 
          LIMIT 50`, [], (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

router.get('/user/:userId', (req, res) => {
  const { userId } = req.params;
  
  db.get('SELECT COUNT(*) as rank FROM games WHERE completed = 1 AND score > (SELECT score FROM games WHERE user_id = ? AND completed = 1 ORDER BY score DESC LIMIT 1)', [userId], (err, row) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ rank: row.rank + 1 });
  });
});

module.exports = router;
