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


## Technology Stack

- **Python 3** + **Flask** — web framework
- **SQLite3** via Python's built-in `sqlite3` module — raw SQL, no ORM
- **Jinja2** server-rendered templates with **DaisyUI / Tailwind CSS** for styling


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
flask --app bikebuild.web run
```

### 3. Open in your browser

```
http://127.0.0.1:5000
```

For development with auto-reload:

```bash
flask --app bikebuild.web run --debug
```

The database ships with **reference data only** (frames, components, standards). Your personal bikes, builds, and inventory start empty.

To reset the reference data from scratch:

```bash
sqlite3 bikebuild.db < schema.sql
sqlite3 bikebuild.db < seed.sql
```

To load the included sample bikes and inventory (optional):

```bash
sqlite3 bikebuild.db < sample_data.sql
```

You can also import/export your data as JSON through the **Data** page in the web UI.

---

## Project Structure

```
BikeBuild/
├── README.md                   This file
├── requirements.txt            Python dependencies
├── bikebuild.db                SQLite3 database file (pre-populated)
├── schema.sql                  DDL script to create all tables
├── seed.sql                    Reference data (frames, components, standards)
├── sample_data.sql             Optional sample bikes, builds, and inventory
│
└── bikebuild/                  Application package
    ├── __init__.py             Package init
    ├── web.py                  Flask routes and raw SQL queries
    ├── templates/              Jinja2 HTML templates
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
    │   ├── inventory_form.html
    │   └── data_manage.html    Import / export user data
    └── static/
        └── style.css           Custom CSS styles
```


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
| **Data Import/Export** | Export bikes & inventory as JSON; import from a previous export |


## Reference Data vs User Data

The database separates **reference data** from **user data**:

| Layer | Tables | Shipped with app? |
|---|---|---|
| **Reference** | `frames`, `components`, `standards`, `frame_standards`, `component_standards` | Yes (`seed.sql`) |
| **User** | `bikes`, `bike_components`, `inventory` | No (create in-app or import) |

A fresh install has the full parts catalog and compatibility standards ready to go. Your personal bikes, build history, and spare parts inventory are managed entirely through the web UI or via JSON import on the **Data** page.

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
