-- Create galaxy table
CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR UNIQUE NOT NULL,
  type VARCHAR NOT NULL,
  age_in_millions_of_years NUMERIC NOT NULL
);

-- Create star table
CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR UNIQUE NOT NULL,
  galaxy_id INT NOT NULL,
  FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id),
  temperature INT NOT NULL,
  is_main_sequence BOOLEAN NOT NULL
);

-- Create planet table
CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR UNIQUE NOT NULL,
  star_id INT NOT NULL,
  FOREIGN KEY (star_id) REFERENCES star(star_id),
  diameter_in_km INT NOT NULL,
  has_atmosphere BOOLEAN NOT NULL
);

-- Create moon table
CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR UNIQUE NOT NULL,
  planet_id INT NOT NULL,
  FOREIGN KEY (planet_id) REFERENCES planet(planet_id),
  distance_from_planet INT NOT NULL,
  is_spherical BOOLEAN NOT NULL
);

-- Create an additional table to meet the 5+ tables requirement
CREATE TABLE celestial_event (
  celestial_event_id SERIAL PRIMARY KEY,
  name VARCHAR UNIQUE NOT NULL,
  galaxy_id INT NOT NULL,
  FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id),
  year_occurred INT NOT NULL,
  description TEXT NOT NULL
);

-- Insert galaxy data (at least 6 rows)
INSERT INTO galaxy (name, type, age_in_millions_of_years) VALUES
('Andromeda', 'Spiral', 10000),
('Milky Way', 'Spiral', 13600),
('Triangulum', 'Spiral', 12000),
('Sombrero', 'Elliptical', 11000),
('Whirlpool', 'Spiral', 9500),
('Pinwheel', 'Spiral', 13000),
('Cartwheel', 'Lenticular', 500);

-- Insert star data (at least 6 rows)
INSERT INTO star (name, galaxy_id, temperature, is_main_sequence) VALUES
('Sirius', 2, 9900, true),
('Betelgeuse', 2, 3500, false),
('Polaris', 2, 7000, true),
('Vega', 2, 9600, true),
('Alpha Centauri', 2, 5790, true),
('Rigel', 2, 11000, true),
('Deneb', 1, 8500, true),
('Altair', 1, 7550, true);

-- Insert planet data (at least 12 rows)
INSERT INTO planet (name, star_id, diameter_in_km, has_atmosphere) VALUES
('Mercury', 1, 4879, false),
('Venus', 1, 12104, true),
('Earth', 1, 12742, true),
('Mars', 1, 6779, true),
('Jupiter', 1, 139820, true),
('Saturn', 1, 116460, true),
('Kepler-452b', 2, 13000, true),
('Proxima b', 5, 10000, true),
('Proxima c', 5, 15000, false),
('TRAPPIST-1e', 6, 11000, true),
('TRAPPIST-1f', 6, 10800, false),
('TRAPPIST-1g', 6, 11200, true),
('Exo-Planet-1', 3, 9000, true);

-- Insert moon data (at least 20 rows)
INSERT INTO moon (name, planet_id, distance_from_planet, is_spherical) VALUES
('Moon', 3, 384400, true),
('Phobos', 4, 9376, true),
('Deimos', 4, 23463, false),
('Io', 5, 421700, true),
('Europa', 5, 671100, true),
('Ganymede', 5, 1070400, true),
('Callisto', 5, 1882600, true),
('Titan', 6, 1222000, true),
('Enceladus', 6, 238000, true),
('Mimas', 6, 185500, false),
('Iapetus', 6, 3560800, true),
('Rhea', 6, 527108, true),
('Dione', 6, 377396, true),
('Tethys', 6, 294619, true),
('Oberon', 7, 583520, true),
('Titania', 7, 435910, true),
('Umbriel', 7, 266300, true),
('Ariel', 7, 191020, true),
('Charon', 8, 19399, true),
('Moonlet-1', 2, 50000, true),
('Moonlet-2', 9, 75000, false),
('Moonlet-3', 10, 60000, true);

-- Insert celestial event data
INSERT INTO celestial_event (name, galaxy_id, year_occurred, description) VALUES
('Big Bang Theory Beginning', 2, -13800, 'The universe began to form'),
('First Stars Formed', 2, -13000, 'First generation of stars appeared'),
('Solar System Formation', 2, -4600, 'Our solar system was formed'),
('Earth Formed', 2, -4500, 'Earth was created'),
('Life on Earth Began', 2, -3800, 'First signs of life'),
('Andromeda Collision', 1, 5000, 'Andromeda galaxy moving towards Milky Way');
