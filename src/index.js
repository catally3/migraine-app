
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
  const body = req.body;
  // then extract your exact fields
  const medicationName = body.medicationName;
  const doseage = body.doseage;
  const medicationType = body.medicationType
  const newItem = await db.any("INSERT INTO \"migraine-app\".medication (name, doseage, type) VALUES ('$1', '$2', '$3')", 
    [medicationName, doseage, medicationType]);
   res.send({
    newItem,
  })
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
 

