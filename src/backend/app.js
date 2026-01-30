require('dotenv').config();
const express = require('express');
const pool = require('./src/db');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const cors = require('cors');

const app = express();

/* routers here like:
const authRouter = require('./routes/auth.router');
*/

app.use(cors({
  origin: [process.env.CLIENT_URL1, process.env.CLIENT_URL2],
  credentials:true,
}));
app.use(express.json({limit: '25mb'}));

app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });
app.use('/api', /* routers here */);

async function initializeApp() {
  try {
    app.listen(process.env.PORT, () => {
      console.log(`Server started on port: ${process.env.PORT}`);
    });
  } catch (error) {
    console.log('Error initializing app:', error);
  }
}

initializeApp();