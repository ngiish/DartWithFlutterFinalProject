// Load environment variables from the .env file
require('dotenv').config({ path: '../.env' });

// Import required modules
const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

// Create an instance of Express
const app = express();
const port = 3000; // Define the port number

// Middleware to parse JSON data in request bodies
app.use(bodyParser.json());

// Middleware to enable Cross-Origin Resource Sharing (CORS)
app.use(cors());

// Create a MySQL database connection
const db = mysql.createConnection({
  host: 'localhost', // Database host
  user: 'root', // Database user
  password: process.env.DB_PASSWORD, // Database password from environment variables
  database: 'event_planner_db' // Database name
});

// Connect to the MySQL database
db.connect(err => {
  if (err) {
    // Throw an error if the connection fails
    throw err;
  }
  console.log('Connected to MySQL database');
});

// Example endpoint to fetch all events from the database
app.get('/events', (req, res) => {
  const sql = 'SELECT * FROM events'; // SQL query to select all events
  db.query(sql, (err, results) => {
    if (err) {
      // Throw an error if the query fails
      throw err;
    }
    // Send the query results as a JSON response
    res.json(results);
  });
});

// Example endpoint to add a new event to the database
app.post('/events/add', (req, res) => {
  const { title, description, date } = req.body; // Destructure the event details from the request body
  const sql = 'INSERT INTO events (title, description, date) VALUES (?, ?, ?)'; // SQL query to insert a new event
  db.query(sql, [title, description, date], (err, result) => {
    if (err) {
      // Throw an error if the query fails
      throw err;
    }
    console.log('Event added:', result); // Log the result to the console
    res.send('Event added'); // Send a response indicating the event was added
  });
});

// Start the server and listen on the specified port
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
