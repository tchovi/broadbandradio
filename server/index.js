const express = require('express');
const http = require('http');
const socket = require('socket.io');
const db = require('./db');
const { scheduleJob } = require('./api');

const app = express();
app.set('view engine','ejs');
app.use(express.static(__dirname + '/../public'));
app.use(express.json());
app.post('/api/schedule', scheduleJob);

app.get('/', async (req, res)=> {
  const playlists = await db.getPlaylists();
  res.render('index',{ playlists });
});

const server = http.createServer(app);
const io = socket(server);

io.on('connection', sock => {
  sock.on('dj-stream', data => {
    io.emit('dj-audio', data);
  });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, ()=>console.log(`Server at http://localhost:${PORT}`));
