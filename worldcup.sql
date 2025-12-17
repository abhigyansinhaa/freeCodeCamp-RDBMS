-- Create the worldcup database
CREATE DATABASE worldcup;

-- Connect to worldcup database and create tables
\c worldcup

-- Create teams table
CREATE TABLE teams (
  team_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) UNIQUE NOT NULL
);

-- Create games table
CREATE TABLE games (
  game_id SERIAL PRIMARY KEY NOT NULL,
  year INTEGER NOT NULL,
  round VARCHAR(255) NOT NULL,
  winner_id INTEGER NOT NULL REFERENCES teams(team_id),
  opponent_id INTEGER NOT NULL REFERENCES teams(team_id),
  winner_goals INTEGER NOT NULL,
  opponent_goals INTEGER NOT NULL
);
