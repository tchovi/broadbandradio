const mariadb = require('mariadb');
const pool = mariadb.createPool({ host:'localhost', user:'root', database:'bbradio' });
module.exports = {
  getPlaylists: async ()=> (await pool.query('SELECT * FROM playlists')),
  addSchedule: async (pl, start, end) =>
    await pool.query('INSERT INTO schedules(pl_id,start,end) VALUES(?,?,?)', [pl,start,end])
};
