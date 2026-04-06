BikeBuild - COMP 3005 Database Project
======================================

Description:
  BikeBuild is a database-backed web application that helps mountain bike
  riders track their bike builds, manage a personal parts inventory, and
  verify component compatibility before buying or installing parts.

SQLite3 Database File:
  Filename: bikebuild.db
  Location: Root of the project folder (same directory as this readme.txt)
  
  You can open and examine it directly with:
    sqlite3 bikebuild.db

Technology:
  - Python 3 + Flask (web framework)
  - SQLite3 via Python's built-in sqlite3 module (raw SQL, no ORM)
  - Jinja2 server-rendered templates with Bootstrap 5 for styling

How to Run:
  1. Create a virtual environment and install dependencies:
       python3 -m venv venv
       source venv/bin/activate      (macOS/Linux)
       venv\Scripts\activate         (Windows)
       pip install -r requirements.txt

  2. Run the application:
       python app.py

  3. Open a browser and go to:
       http://127.0.0.1:5000

  The database (bikebuild.db) comes pre-loaded with sample data.
  To reset the database from scratch, run:
       sqlite3 bikebuild.db < schema.sql
       sqlite3 bikebuild.db < seed.sql

Project Files:
  app.py              - Flask application with all routes and raw SQL queries
  schema.sql          - DDL script to create all tables
  seed.sql            - INSERT statements with sample mountain bike data
  bikebuild.db        - The SQLite3 database file (pre-populated)
  requirements.txt    - Python dependencies (flask)
  readme.txt          - This file
  templates/          - Jinja2 HTML templates for the web UI
  static/style.css    - Custom CSS styles

YouTube Demonstration:
  [Insert YouTube link here]
