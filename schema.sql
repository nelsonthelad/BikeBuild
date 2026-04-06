PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS bikes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    brand TEXT NOT NULL,
    model TEXT NOT NULL,
    year INTEGER,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS components (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    manufacturer TEXT NOT NULL,
    model TEXT NOT NULL,
    component_type TEXT NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS standards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category TEXT NOT NULL,
    value TEXT NOT NULL,
    description TEXT,
    UNIQUE(category, value)
);

CREATE TABLE IF NOT EXISTS bike_components (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    bike_id INTEGER NOT NULL REFERENCES bikes(id) ON DELETE CASCADE,
    component_id INTEGER NOT NULL REFERENCES components(id) ON DELETE CASCADE,
    position TEXT,
    install_date TEXT,
    removal_date TEXT,
    price REAL,
    condition_notes TEXT
);

CREATE TABLE IF NOT EXISTS component_standards (
    component_id INTEGER NOT NULL REFERENCES components(id) ON DELETE CASCADE,
    standard_id INTEGER NOT NULL REFERENCES standards(id) ON DELETE CASCADE,
    PRIMARY KEY (component_id, standard_id)
);

CREATE TABLE IF NOT EXISTS bike_standards (
    bike_id INTEGER NOT NULL REFERENCES bikes(id) ON DELETE CASCADE,
    standard_id INTEGER NOT NULL REFERENCES standards(id) ON DELETE CASCADE,
    PRIMARY KEY (bike_id, standard_id)
);

CREATE TABLE IF NOT EXISTS inventory (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    component_id INTEGER NOT NULL REFERENCES components(id) ON DELETE CASCADE,
    condition TEXT,
    intended_bike_id INTEGER REFERENCES bikes(id) ON DELETE SET NULL,
    notes TEXT
);
