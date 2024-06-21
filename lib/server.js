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
    console.error('Error connecting to the database:', err);
    process.exit(1);
  }
  console.log('Connected to MySQL database');
});

// The API endpoints
// Endpoint to fetch all events from the database
app.get('/events', (req, res) => {
  const sql = 'SELECT * FROM events'; // SQL query to select all events
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching events:', err);
      return res.status(500).json({ message: 'Server error' });
    }
    // Send the query results as a JSON response
    res.json(results);
  });
});

// Endpoint to add a new event to the database
app.post('/events/add', (req, res) => {
  const { title, description, date } = req.body; // Destructure the event details from the request body
  const sql = 'INSERT INTO events (title, description, date) VALUES (?, ?, ?)'; // SQL query to insert a new event
  db.query(sql, [title, description, date], (err, result) => {
    if (err) {
      console.error('Error adding event:', err);
      return res.status(500).json({ message: 'Server error' });
    }
    console.log('Event added:', result); // Log the result to the console
    res.status(201).json({ message: 'Event added successfully' }); // Send a response indicating the event was added
  });
});

// Endpoint for user login
app.post('/login', (req, res) => {
  const { email, password } = req.body; // Destructure email and password from request body
  const query = 'SELECT * FROM users WHERE email = ? AND password = ?'; // SQL query to check user credentials
  db.query(query, [email, password], (err, results) => {
    if (err) {
      console.error('Error during login:', err);
      return res.status(500).json({ message: 'Server error' });
    }
    if (results.length > 0) {
      // If the user exists, send authenticated response
      res.json({ authenticated: true });
    } else {
      // If the user doesn't exist, send not authenticated response
      res.json({ authenticated: false });
    }
  });
});

// Endpoint for user signup
app.post('/signup', (req, res) => {
  const { username, email, password } = req.body; // Ensure the field names match your database
  if (!username || !email || !password) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  const sql = 'INSERT INTO users (username, email, password) VALUES (?, ?, ?)'; // Ensure the field names match your database
  db.query(sql, [username, email, password], (err, result) => {
    if (err) {
      console.error('Error signing up user:', err);
      return res.status(500).json({ message: 'Server error' });
    }
    console.log('User signed up:', result);
    res.status(201).json({ message: 'User signed up successfully' });
  });
});

// Start the server and listen on the specified port
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
