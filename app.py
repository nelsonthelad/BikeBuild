import sqlite3
import os
from flask import Flask, render_template, request, redirect, url_for, g, flash

app = Flask(__name__)
app.secret_key = 'bikebuild-dev-key'
DATABASE = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'bikebuild.db')


# ---------------------------------------------------------------------------
# Database helpers
# ---------------------------------------------------------------------------

def get_db():
    if 'db' not in g:
        g.db = sqlite3.connect(DATABASE)
        g.db.row_factory = sqlite3.Row
        g.db.execute("PRAGMA foreign_keys = ON")
    return g.db


@app.teardown_appcontext
def close_db(exception):
    db = g.pop('db', None)
    if db is not None:
        db.close()


def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv


def execute_db(query, args=()):
    db = get_db()
    db.execute(query, args)
    db.commit()


# ---------------------------------------------------------------------------
# Home / Dashboard
# ---------------------------------------------------------------------------

@app.route('/')
def index():
    bike_count = query_db("SELECT COUNT(*) AS c FROM bikes", one=True)['c']
    component_count = query_db("SELECT COUNT(*) AS c FROM components", one=True)['c']
    inventory_count = query_db("SELECT COUNT(*) AS c FROM inventory", one=True)['c']
    recent_installs = query_db("""
        SELECT bc.install_date, b.name AS bike_name, b.id AS bike_id,
               c.manufacturer || ' ' || c.model AS part_name, bc.position
        FROM bike_components bc
        JOIN bikes b ON bc.bike_id = b.id
        JOIN components c ON bc.component_id = c.id
        ORDER BY bc.install_date DESC
        LIMIT 5
    """)
    return render_template('index.html',
                           bike_count=bike_count,
                           component_count=component_count,
                           inventory_count=inventory_count,
                           recent_installs=recent_installs)


# ---------------------------------------------------------------------------
# Bikes
# ---------------------------------------------------------------------------

@app.route('/bikes')
def bikes_list():
    bikes = query_db("""
        SELECT b.*,
               COUNT(CASE WHEN bc.removal_date IS NULL THEN 1 END) AS installed_count,
               COALESCE(SUM(CASE WHEN bc.removal_date IS NULL THEN bc.price ELSE 0 END), 0) AS total_cost
        FROM bikes b
        LEFT JOIN bike_components bc ON b.id = bc.bike_id
        GROUP BY b.id
        ORDER BY b.year DESC
    """)
    return render_template('bikes.html', bikes=bikes)


@app.route('/bikes/new', methods=['GET', 'POST'])
def bike_new():
    standards = query_db("SELECT * FROM standards ORDER BY category, value")
    categories = sorted(set(s['category'] for s in standards))
    if request.method == 'POST':
        db = get_db()
        cur = db.execute(
            "INSERT INTO bikes (name, brand, model, year, notes) VALUES (?, ?, ?, ?, ?)",
            (request.form['name'], request.form['brand'], request.form['model'],
             request.form.get('year') or None, request.form.get('notes') or None)
        )
        bike_id = cur.lastrowid
        for std_id in request.form.getlist('standards'):
            db.execute("INSERT INTO bike_standards (bike_id, standard_id) VALUES (?, ?)",
                       (bike_id, std_id))
        db.commit()
        flash('Bike created successfully.', 'success')
        return redirect(url_for('bike_detail', bike_id=bike_id))
    return render_template('bike_form.html', bike=None, standards=standards, categories=categories)


@app.route('/bikes/<int:bike_id>')
def bike_detail(bike_id):
    bike = query_db("SELECT * FROM bikes WHERE id = ?", (bike_id,), one=True)
    if not bike:
        flash('Bike not found.', 'danger')
        return redirect(url_for('bikes_list'))

    installed = query_db("""
        SELECT bc.*, c.manufacturer, c.model AS comp_model, c.component_type, c.description AS comp_desc
        FROM bike_components bc
        JOIN components c ON bc.component_id = c.id
        WHERE bc.bike_id = ? AND bc.removal_date IS NULL
        ORDER BY bc.position
    """, (bike_id,))

    bike_stds = query_db("""
        SELECT s.category, s.value, s.description
        FROM bike_standards bs
        JOIN standards s ON bs.standard_id = s.id
        WHERE bs.bike_id = ?
        ORDER BY s.category
    """, (bike_id,))

    total_cost = sum(r['price'] or 0 for r in installed)

    return render_template('bike_detail.html', bike=bike, installed=installed,
                           bike_stds=bike_stds, total_cost=total_cost)


@app.route('/bikes/<int:bike_id>/edit', methods=['GET', 'POST'])
def bike_edit(bike_id):
    bike = query_db("SELECT * FROM bikes WHERE id = ?", (bike_id,), one=True)
    if not bike:
        flash('Bike not found.', 'danger')
        return redirect(url_for('bikes_list'))

    standards = query_db("SELECT * FROM standards ORDER BY category, value")
    categories = sorted(set(s['category'] for s in standards))
    current_std_ids = [r['standard_id'] for r in query_db(
        "SELECT standard_id FROM bike_standards WHERE bike_id = ?", (bike_id,)
    )]

    if request.method == 'POST':
        db = get_db()
        db.execute(
            "UPDATE bikes SET name=?, brand=?, model=?, year=?, notes=? WHERE id=?",
            (request.form['name'], request.form['brand'], request.form['model'],
             request.form.get('year') or None, request.form.get('notes') or None, bike_id)
        )
        db.execute("DELETE FROM bike_standards WHERE bike_id = ?", (bike_id,))
        for std_id in request.form.getlist('standards'):
            db.execute("INSERT INTO bike_standards (bike_id, standard_id) VALUES (?, ?)",
                       (bike_id, std_id))
        db.commit()
        flash('Bike updated.', 'success')
        return redirect(url_for('bike_detail', bike_id=bike_id))

    return render_template('bike_form.html', bike=bike, standards=standards,
                           categories=categories, current_std_ids=current_std_ids)


@app.route('/bikes/<int:bike_id>/delete', methods=['POST'])
def bike_delete(bike_id):
    execute_db("DELETE FROM bikes WHERE id = ?", (bike_id,))
    flash('Bike deleted.', 'info')
    return redirect(url_for('bikes_list'))


# ---------------------------------------------------------------------------
# Bike - Install / Remove / History
# ---------------------------------------------------------------------------

@app.route('/bikes/<int:bike_id>/install', methods=['GET', 'POST'])
def bike_install(bike_id):
    bike = query_db("SELECT * FROM bikes WHERE id = ?", (bike_id,), one=True)
    if not bike:
        flash('Bike not found.', 'danger')
        return redirect(url_for('bikes_list'))

    if request.method == 'POST':
        execute_db("""
            INSERT INTO bike_components (bike_id, component_id, position, install_date, price, condition_notes)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (bike_id, request.form['component_id'], request.form.get('position'),
              request.form.get('install_date'), request.form.get('price') or None,
              request.form.get('condition_notes')))
        flash('Component installed.', 'success')
        return redirect(url_for('bike_detail', bike_id=bike_id))

    components = query_db("SELECT * FROM components ORDER BY component_type, manufacturer")
    return render_template('bike_install.html', bike=bike, components=components)


@app.route('/bikes/<int:bike_id>/remove/<int:bc_id>', methods=['POST'])
def bike_remove(bike_id, bc_id):
    execute_db(
        "UPDATE bike_components SET removal_date = date('now') WHERE id = ? AND bike_id = ?",
        (bc_id, bike_id)
    )
    flash('Component removed.', 'info')
    return redirect(url_for('bike_detail', bike_id=bike_id))


@app.route('/bikes/<int:bike_id>/history')
def bike_history(bike_id):
    bike = query_db("SELECT * FROM bikes WHERE id = ?", (bike_id,), one=True)
    if not bike:
        flash('Bike not found.', 'danger')
        return redirect(url_for('bikes_list'))
    history = query_db("""
        SELECT bc.*, c.manufacturer, c.model AS comp_model, c.component_type
        FROM bike_components bc
        JOIN components c ON bc.component_id = c.id
        WHERE bc.bike_id = ?
        ORDER BY bc.install_date DESC
    """, (bike_id,))
    return render_template('bike_history.html', bike=bike, history=history)


# ---------------------------------------------------------------------------
# Compatibility Checker
# ---------------------------------------------------------------------------

@app.route('/bikes/<int:bike_id>/compatibility')
def compatibility_check(bike_id):
    bike = query_db("SELECT * FROM bikes WHERE id = ?", (bike_id,), one=True)
    if not bike:
        flash('Bike not found.', 'danger')
        return redirect(url_for('bikes_list'))

    components = query_db("SELECT * FROM components ORDER BY component_type, manufacturer")
    component_id = request.args.get('component_id', type=int)
    result = None
    selected_component = None

    if component_id:
        selected_component = query_db("SELECT * FROM components WHERE id = ?", (component_id,), one=True)

        mismatches = query_db("""
            SELECT bs_sub.category, bs_sub.value AS bike_value, cs_sub.value AS component_value
            FROM (
                SELECT s.category, s.value
                FROM bike_standards bst
                JOIN standards s ON bst.standard_id = s.id
                WHERE bst.bike_id = ?
            ) bs_sub
            JOIN (
                SELECT s.category, s.value
                FROM component_standards cst
                JOIN standards s ON cst.standard_id = s.id
                WHERE cst.component_id = ?
            ) cs_sub ON bs_sub.category = cs_sub.category
            WHERE bs_sub.value != cs_sub.value
        """, (bike_id, component_id))

        matches = query_db("""
            SELECT bs_sub.category, bs_sub.value AS bike_value, cs_sub.value AS component_value
            FROM (
                SELECT s.category, s.value
                FROM bike_standards bst
                JOIN standards s ON bst.standard_id = s.id
                WHERE bst.bike_id = ?
            ) bs_sub
            JOIN (
                SELECT s.category, s.value
                FROM component_standards cst
                JOIN standards s ON cst.standard_id = s.id
                WHERE cst.component_id = ?
            ) cs_sub ON bs_sub.category = cs_sub.category
            WHERE bs_sub.value = cs_sub.value
        """, (bike_id, component_id))

        result = {
            'compatible': len(mismatches) == 0,
            'mismatches': mismatches,
            'matches': matches,
        }

    return render_template('compatibility.html', bike=bike, components=components,
                           component_id=component_id, selected_component=selected_component,
                           result=result)


# ---------------------------------------------------------------------------
# Build Sheet
# ---------------------------------------------------------------------------

@app.route('/bikes/<int:bike_id>/build-sheet')
def build_sheet(bike_id):
    bike = query_db("SELECT * FROM bikes WHERE id = ?", (bike_id,), one=True)
    if not bike:
        flash('Bike not found.', 'danger')
        return redirect(url_for('bikes_list'))

    installed = query_db("""
        SELECT bc.position, bc.install_date, bc.price, bc.condition_notes,
               c.manufacturer, c.model AS comp_model, c.component_type, c.description AS comp_desc
        FROM bike_components bc
        JOIN components c ON bc.component_id = c.id
        WHERE bc.bike_id = ? AND bc.removal_date IS NULL
        ORDER BY bc.position
    """, (bike_id,))

    bike_stds = query_db("""
        SELECT s.category, s.value
        FROM bike_standards bs
        JOIN standards s ON bs.standard_id = s.id
        WHERE bs.bike_id = ?
        ORDER BY s.category
    """, (bike_id,))

    total_cost = sum(r['price'] or 0 for r in installed)

    return render_template('build_sheet.html', bike=bike, installed=installed,
                           bike_stds=bike_stds, total_cost=total_cost)


# ---------------------------------------------------------------------------
# Components
# ---------------------------------------------------------------------------

@app.route('/components')
def components_list():
    search = request.args.get('q', '').strip()
    comp_type = request.args.get('type', '').strip()

    sql = """
        SELECT c.*,
               GROUP_CONCAT(s.category || ': ' || s.value, ', ') AS std_summary
        FROM components c
        LEFT JOIN component_standards cs ON c.id = cs.component_id
        LEFT JOIN standards s ON cs.standard_id = s.id
        WHERE 1=1
    """
    params = []

    if search:
        sql += " AND (c.manufacturer LIKE ? OR c.model LIKE ? OR c.description LIKE ?)"
        like = f'%{search}%'
        params.extend([like, like, like])
    if comp_type:
        sql += " AND c.component_type = ?"
        params.append(comp_type)

    sql += " GROUP BY c.id ORDER BY c.component_type, c.manufacturer"

    components = query_db(sql, params)
    types = query_db("SELECT DISTINCT component_type FROM components ORDER BY component_type")
    return render_template('components.html', components=components, types=types,
                           search=search, comp_type=comp_type)


@app.route('/components/<int:comp_id>')
def component_detail(comp_id):
    comp = query_db("SELECT * FROM components WHERE id = ?", (comp_id,), one=True)
    if not comp:
        flash('Component not found.', 'danger')
        return redirect(url_for('components_list'))

    stds = query_db("""
        SELECT s.category, s.value, s.description
        FROM component_standards cs
        JOIN standards s ON cs.standard_id = s.id
        WHERE cs.component_id = ?
        ORDER BY s.category
    """, (comp_id,))

    installs = query_db("""
        SELECT bc.*, b.name AS bike_name, b.id AS bike_id
        FROM bike_components bc
        JOIN bikes b ON bc.bike_id = b.id
        WHERE bc.component_id = ?
        ORDER BY bc.install_date DESC
    """, (comp_id,))

    return render_template('component_detail.html', comp=comp, stds=stds, installs=installs)


@app.route('/components/new', methods=['GET', 'POST'])
def component_new():
    standards = query_db("SELECT * FROM standards ORDER BY category, value")
    categories = sorted(set(s['category'] for s in standards))
    if request.method == 'POST':
        db = get_db()
        cur = db.execute(
            "INSERT INTO components (manufacturer, model, component_type, description) VALUES (?, ?, ?, ?)",
            (request.form['manufacturer'], request.form['model'],
             request.form['component_type'], request.form.get('description') or None)
        )
        comp_id = cur.lastrowid
        for std_id in request.form.getlist('standards'):
            db.execute("INSERT INTO component_standards (component_id, standard_id) VALUES (?, ?)",
                       (comp_id, std_id))
        db.commit()
        flash('Component added.', 'success')
        return redirect(url_for('component_detail', comp_id=comp_id))
    types = query_db("SELECT DISTINCT component_type FROM components ORDER BY component_type")
    return render_template('component_form.html', comp=None, standards=standards,
                           categories=categories, types=types)


@app.route('/components/<int:comp_id>/edit', methods=['GET', 'POST'])
def component_edit(comp_id):
    comp = query_db("SELECT * FROM components WHERE id = ?", (comp_id,), one=True)
    if not comp:
        flash('Component not found.', 'danger')
        return redirect(url_for('components_list'))

    standards = query_db("SELECT * FROM standards ORDER BY category, value")
    categories = sorted(set(s['category'] for s in standards))
    current_std_ids = [r['standard_id'] for r in query_db(
        "SELECT standard_id FROM component_standards WHERE component_id = ?", (comp_id,)
    )]

    if request.method == 'POST':
        db = get_db()
        db.execute(
            "UPDATE components SET manufacturer=?, model=?, component_type=?, description=? WHERE id=?",
            (request.form['manufacturer'], request.form['model'],
             request.form['component_type'], request.form.get('description') or None, comp_id)
        )
        db.execute("DELETE FROM component_standards WHERE component_id = ?", (comp_id,))
        for std_id in request.form.getlist('standards'):
            db.execute("INSERT INTO component_standards (component_id, standard_id) VALUES (?, ?)",
                       (comp_id, std_id))
        db.commit()
        flash('Component updated.', 'success')
        return redirect(url_for('component_detail', comp_id=comp_id))

    types = query_db("SELECT DISTINCT component_type FROM components ORDER BY component_type")
    return render_template('component_form.html', comp=comp, standards=standards,
                           categories=categories, current_std_ids=current_std_ids, types=types)


@app.route('/components/<int:comp_id>/delete', methods=['POST'])
def component_delete(comp_id):
    execute_db("DELETE FROM components WHERE id = ?", (comp_id,))
    flash('Component deleted.', 'info')
    return redirect(url_for('components_list'))


# ---------------------------------------------------------------------------
# Inventory
# ---------------------------------------------------------------------------

@app.route('/inventory')
def inventory_list():
    items = query_db("""
        SELECT inv.*, c.manufacturer, c.model AS comp_model, c.component_type,
               b.name AS intended_bike_name
        FROM inventory inv
        JOIN components c ON inv.component_id = c.id
        LEFT JOIN bikes b ON inv.intended_bike_id = b.id
        ORDER BY c.component_type, c.manufacturer
    """)
    return render_template('inventory.html', items=items)


@app.route('/inventory/add', methods=['GET', 'POST'])
def inventory_add():
    if request.method == 'POST':
        execute_db(
            "INSERT INTO inventory (component_id, condition, intended_bike_id, notes) VALUES (?, ?, ?, ?)",
            (request.form['component_id'], request.form.get('condition'),
             request.form.get('intended_bike_id') or None, request.form.get('notes'))
        )
        flash('Item added to inventory.', 'success')
        return redirect(url_for('inventory_list'))

    components = query_db("SELECT * FROM components ORDER BY component_type, manufacturer")
    bikes = query_db("SELECT * FROM bikes ORDER BY name")
    return render_template('inventory_form.html', item=None, components=components, bikes=bikes)


@app.route('/inventory/<int:inv_id>/edit', methods=['GET', 'POST'])
def inventory_edit(inv_id):
    item = query_db("SELECT * FROM inventory WHERE id = ?", (inv_id,), one=True)
    if not item:
        flash('Inventory item not found.', 'danger')
        return redirect(url_for('inventory_list'))

    if request.method == 'POST':
        execute_db(
            "UPDATE inventory SET component_id=?, condition=?, intended_bike_id=?, notes=? WHERE id=?",
            (request.form['component_id'], request.form.get('condition'),
             request.form.get('intended_bike_id') or None, request.form.get('notes'), inv_id)
        )
        flash('Inventory item updated.', 'success')
        return redirect(url_for('inventory_list'))

    components = query_db("SELECT * FROM components ORDER BY component_type, manufacturer")
    bikes = query_db("SELECT * FROM bikes ORDER BY name")
    return render_template('inventory_form.html', item=item, components=components, bikes=bikes)


@app.route('/inventory/<int:inv_id>/delete', methods=['POST'])
def inventory_delete(inv_id):
    execute_db("DELETE FROM inventory WHERE id = ?", (inv_id,))
    flash('Inventory item removed.', 'info')
    return redirect(url_for('inventory_list'))


# ---------------------------------------------------------------------------
# Upgrade Planner
# ---------------------------------------------------------------------------

@app.route('/bikes/<int:bike_id>/upgrade-plan')
def upgrade_plan(bike_id):
    bike = query_db("SELECT * FROM bikes WHERE id = ?", (bike_id,), one=True)
    if not bike:
        flash('Bike not found.', 'danger')
        return redirect(url_for('bikes_list'))

    installed_types = query_db("""
        SELECT DISTINCT c.component_type
        FROM bike_components bc
        JOIN components c ON bc.component_id = c.id
        WHERE bc.bike_id = ? AND bc.removal_date IS NULL
    """, (bike_id,))
    installed_type_set = {r['component_type'] for r in installed_types}

    all_types = query_db("SELECT DISTINCT component_type FROM components ORDER BY component_type")
    missing_types = [r['component_type'] for r in all_types if r['component_type'] not in installed_type_set]

    compatible_candidates = query_db("""
        SELECT c.*, GROUP_CONCAT(s.category || ': ' || s.value, ', ') AS std_summary
        FROM components c
        LEFT JOIN component_standards cs ON c.id = cs.component_id
        LEFT JOIN standards s ON cs.standard_id = s.id
        WHERE c.id NOT IN (
            SELECT bc.component_id FROM bike_components bc
            WHERE bc.bike_id = ? AND bc.removal_date IS NULL
        )
        AND NOT EXISTS (
            SELECT 1
            FROM (
                SELECT s2.category, s2.value
                FROM bike_standards bst
                JOIN standards s2 ON bst.standard_id = s2.id
                WHERE bst.bike_id = ?
            ) bs
            JOIN (
                SELECT s3.category, s3.value
                FROM component_standards cst2
                JOIN standards s3 ON cst2.standard_id = s3.id
                WHERE cst2.component_id = c.id
            ) cs2 ON bs.category = cs2.category
            WHERE bs.value != cs2.value
        )
        GROUP BY c.id
        ORDER BY c.component_type, c.manufacturer
    """, (bike_id, bike_id))

    return render_template('upgrade_plan.html', bike=bike, missing_types=missing_types,
                           candidates=compatible_candidates)


# ---------------------------------------------------------------------------
# Run
# ---------------------------------------------------------------------------

if __name__ == '__main__':
    app.run(debug=True, port=5000)
