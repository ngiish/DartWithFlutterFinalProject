## Event Planner app
The Event Planner App is a Flutter application that allows users to plan and manage their events efficiently. This application uses a Node.js backend with Express to handle event data and a MySQL database for data storage.


## Author
Isaac Mutiga

## Features
View events on a calendar.
Add new events with title and description.
View a list of events for the selected day.
Persist event data using a backend server with MySQL.

## Getting Started
To start using the Event Manager App, follow these steps:

1. Clone the repository:
git clone git@github.com:ngiish/DartWithFlutterFinalProject.git


2. Navigate to the project directory:
cd DartWithFlutterFinalProject


3. **Install dependencies:** 
flutter pub get # Install all the dependencies that work with flutter
npm install # Install the other app dependencies



4. Configure environment variables:
- Set up environment variables for database connection, API keys, etc.

5. Start the Flutter app/run the app:

     Flutter run

6. Start the node.js development server:

     (1)npm start


7. Access the application via [http://localhost:3000](http://localhost:3000) in your browser.

-To check whether the MySQL server is running/status of the server:
      (1)sudo service mysql status

## Technologies Used
Dart 
Flutter
Node.js
MySQL

## Key Components

# Frontend:

- Flutter: Utilized for creating the user interface. Flutter allows for a seamless and responsive design, making the app user-friendly and visually appealing.
- State Management: Provider package is used for state management, ensuring that the app state is managed efficiently and changes are propagated correctly across the app.

# Backend:

- Node.js: Serves as the backend server, handling HTTP requests from the Flutter app and interacting with the MySQL database.
- Express.js: Used to create RESTful API endpoints for CRUD operations on the event data.
- MySQL: Database for storing event details, including titles, descriptions