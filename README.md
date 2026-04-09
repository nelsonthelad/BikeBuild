# BikeBuild

BikeBuild is a database-backed web application that helps mountain bike riders track their bike builds, manage a personal parts inventory, and verify component compatibility before buying or installing parts.

---

## SQLite3 Database

| | |
|---|---|
| **Filename** | `bikebuild.db` |
| **Location** | Root of the project folder (same directory as this README) |

You can open and examine the database directly with:

```bash
sqlite3 bikebuild.db
```

---

## Technology Stack

- **Python 3** + **Flask** — web framework
- **SQLite3** via Python's built-in `sqlite3` module — raw SQL, no ORM
- **Jinja2** server-rendered templates with **DaisyUI / Tailwind CSS** for styling

---

## Getting Started

### 1. Create a virtual environment and install dependencies

```bash
python3 -m venv venv
source venv/bin/activate        # macOS / Linux
venv\Scripts\activate           # Windows
pip install -r requirements.txt
```

### 2. Run the application

```bash
python app.py
```

### 3. Open in your browser

```
http://127.0.0.1:5000
```

The database (`bikebuild.db`) comes **pre-loaded with sample data**. To reset from scratch:

```bash
sqlite3 bikebuild.db < schema.sql
sqlite3 bikebuild.db < seed.sql
```

---

## Project Structure

```
BikeBuild/
├── app.py                  Flask application with all routes and raw SQL queries
├── bikebuild.db            SQLite3 database file (pre-populated)
├── schema.sql              DDL script to create all tables
├── seed.sql                INSERT statements with sample mountain bike data
├── requirements.txt        Python dependencies
├── readme.txt              Plain-text readme
├── README.md               This file
├── ER-Model.png            Entity-Relationship diagram
├── Table-Schema.png        Table schema diagram
├── templates/              Jinja2 HTML templates for the web UI
│   ├── base.html
│   ├── index.html          Dashboard
│   ├── bikes.html          Bike list
│   ├── bike_detail.html    Bike detail view
│   ├── bike_form.html      Create / edit bike
│   ├── bike_install.html   Install component on a bike
│   ├── bike_history.html   Component install history
│   ├── build_sheet.html    Printable build sheet
│   ├── compatibility.html  Compatibility checker
│   ├── upgrade_plan.html   Upgrade planner
│   ├── components.html     Component catalog
│   ├── component_detail.html
│   ├── component_form.html
│   ├── inventory.html      Spare parts inventory
│   └── inventory_form.html
└── static/
    └── style.css           Custom CSS styles
```

---

## Key Features

| Feature | Description |
|---|---|
| **Bike Manager** | Create bikes, assign frames, and track full builds |
| **Component Catalog** | Browse, search, and filter all components by type |
| **Compatibility Checker** | Compare frame standards vs component standards to catch mismatches |
| **Build Sheet** | View a complete summary of every part installed on a bike |
| **Upgrade Planner** | Find compatible components not yet installed on a bike |
| **Install History** | Track when parts were installed and removed, with pricing |
| **Parts Inventory** | Manage spare parts and earmark them for future builds |

---

## Database Schema

The database contains **8 tables** mapped directly from the ER model:

| Table | Purpose |
|---|---|
| `frames` | Bike frame details (brand, model, year) |
| `bikes` | Named bike builds, each linked to a frame |
| `components` | Parts catalog (forks, wheels, brakes, etc.) |
| `standards` | Compatibility standards (wheel size, axle spacing, etc.) |
| `bike_components` | Junction table tracking which parts are installed on which bikes |
| `component_standards` | Links components to the standards they support |
| `frame_standards` | Links frames to the standards they require |
| `inventory` | Spare parts not currently installed on any bike |

---

## YouTube Demonstration

[Insert YouTube link here]
