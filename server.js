const express = require('express');
const mongoose = require('mongoose');

const app = express();
app.use(express.json());

mongoose.connect(process.env.MONGO_URL);

const Visit = mongoose.model('Visit', { date: Date });

app.get('/', async (req, res) => {
    await Visit.create({ date: new Date() });
    const count = await Visit.countDocuments();
    res.json({ message: 'Hello from Node + MongoDB!', visits: count });
});

app.get('/health', (req, res) => res.send('OK'));

app.listen(3000, '0.0.0.0');
