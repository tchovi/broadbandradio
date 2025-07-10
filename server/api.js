const db = require('./db');
exports.scheduleJob = async (req, res) => {
  try {
    let { playlistId, startTime, endTime } = req.body;
    await db.addSchedule(playlistId, startTime, endTime);
    res.json({ success:true });
  } catch(e){ res.status(500).json({ error:e.message }); }
};
