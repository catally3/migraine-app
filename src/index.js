
const express = require('express')
const app = express()
const port = process.env.PORT || 3000
const pgp = require('pg-promise')()
const cn = {
  host: 'host.docker.internal',
  port: 5434,
  database: process.env.POSTGRES_DATABASE,
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  max: 30 // use up to 30 connections

  // "types" - in case you want to set custom type parsers on the pool level
};

const db = pgp(cn);


app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/medications', async (req, res) => {
  try {
    const meds = await db.any('SELECT * FROM "migraine-app".medication');
    res.send(meds);
    // success
  } 
  catch(e) {
    // error
  }
})

app.post('/medication', async (req, res) => {
  /*const body = req.body;
  // then extract your exact fields
  const medicationName = body.medicationName;
  const doseage = body.doseage;
  const medicationType = body.medicationType
  */
  const medicationName = req.get('medicationName');
  const doseage = req.get('doseage');
  const medicationType = req.get('medicationType')
  const newItem = await db.any("INSERT INTO \"migraine-app\".medication (name, doseage, type) VALUES ($1, $2, $3)", 
    [medicationName, doseage, medicationType]);
   res.send({
    newItem,
  })
})

app.post('/trigger', async (req, res) => {
  const triggerName = req.get('triggerName');
  const triggerDescription = req.get('triggerDescription');
  const isFood = req.get('isFood')
  const newItem = await db.any("INSERT INTO \"migraine-app\".trigger (name, description, is_food) VALUES ($1, $2, $3)", 
    [triggerName, triggerDescription, isFood]);
   res.send(await db.any('SELECT id FROM "migraine-app".trigger WHERE name = $1 AND description = $2 AND is_food = $3', [triggerName, triggerDescription, isFood]))
})

app.get("/medications/:id", 
  async (req, res) => { 
      const id = req.params.id // parse from req
      const store_info = await db.any("SELECT * FROM \"migraine-app\".medication WHERE id=$1", [id])// query the db
      res.send({
        store_info  // send the data back
      })
  });
  

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
 

