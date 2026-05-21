const express = require('express');
const axios = require('axios');
const { db } = require('../config/database');

const router = express.Router();
const UNSPLASH_KEY = process.env.UNSPLASH_ACCESS_KEY;
const QUESTION_API_KEY = process.env.QUESTION_API_ACCESS_KEY;

router.get('/random', async (req, res) => {
  try {
    const { limit = 15, categories, difficulties, types = 'text_choice' } = req.query;
    
    const params = { amount: limit };
    if (QUESTION_API_KEY) {
      params.token = QUESTION_API_KEY;
    }
    
    const response = await axios.get('https://opentdb.com/api.php', {
      params
    });
    
    if (response.data.response_code === 0) {
      const formatted = response.data.results.map(q => ({
        question: q.question,
        correct_answer: q.correct_answer,
        incorrect_answers: q.incorrect_answers,
        category: q.category,
        difficulty: q.difficulty,
        type: q.type,
        id: q.question,
        tags: []
      }));
      
      res.json({ results: formatted });
    } else {
      throw new Error('No questions returned from API');
    }
  } catch (error) {
    console.error('OpenTDB API error:', error.message);
    res.status(500).json({ error: 'Failed to fetch trivia questions' });
  }
});

router.get('/image', async (req, res) => {
  const { query } = req.query;
  if (!query) return res.status(400).json({ error: 'Query required' });
  
  try {
    const response = await axios.get(`https://api.unsplash.com/search/photos`, {
      params: { query: query, per_page: 1 },
      headers: { Authorization: `Client-ID ${UNSPLASH_KEY}` }
    });
    
    if (response.data.results.length > 0) {
      res.json({ url: response.data.results[0].urls.small });
    } else {
      res.json({ url: `https://picsum.photos/400/300?random=${Date.now()}` });
    }
  } catch (error) {
    res.json({ url: `https://picsum.photos/400/300?random=${Date.now()}` });
  }
});

router.get('/categories', async (req, res) => {
  try {
    const response = await axios.get('https://opentdb.com/api_category.php');
    const categories = response.data.trivia_categories.map(cat => cat.name);
    res.json(categories);
  } catch (error) {
    console.error('OpenTDB categories error:', error.message);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
});

router.get('/tags', async (req, res) => {
  res.json([]);
});

module.exports = router;
