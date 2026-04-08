-- ============================================================
-- Standards
-- ============================================================
INSERT INTO standards (category, value, description) VALUES
    ('wheel_size',      '29"',              '29 inch (622mm BSD) wheel diameter'),
    ('wheel_size',      '27.5"',            '27.5 inch (584mm BSD) wheel diameter'),
    ('rear_spacing',    'Boost 148x12',     'Boost rear hub: 148mm OLD, 12mm thru-axle'),
    ('rear_spacing',    'SuperBoost 157',   'SuperBoost Plus: 157mm OLD, 12mm thru-axle'),
    ('rear_spacing',    'Standard 142x12',  'Standard rear hub: 142mm OLD, 12mm thru-axle'),
    ('hub_driver',      'Shimano HG',       'Shimano HyperGlide freehub driver'),
    ('hub_driver',      'SRAM XD',          'SRAM XD freehub driver'),
    ('hub_driver',      'Shimano MS',       'Shimano Micro Spline freehub driver'),
    ('bb_standard',     'BSA 73mm',         'Threaded BSA bottom bracket, 73mm shell'),
    ('bb_standard',     'PF92',             'Press-fit 92mm bottom bracket shell'),
    ('seatpost_diameter','31.6mm',          '31.6mm seatpost diameter'),
    ('seatpost_diameter','34.9mm',          '34.9mm seatpost diameter'),
    ('seatpost_diameter','30.9mm',          '30.9mm seatpost diameter'),
    ('headset',         'ZS44/ZS56',        'Zero Stack 44mm upper / 56mm lower'),
    ('headset',         'IS42/IS52',        'Integrated 42mm upper / 52mm lower'),
    ('brake_mount',     'Post Mount',       'Post mount brake caliper standard'),
    ('brake_mount',     'Flat Mount',       'Flat mount brake caliper standard (road/gravel)'),
    ('rotor_size',      '180mm',            '180mm disc brake rotor'),
    ('rotor_size',      '200mm',            '200mm disc brake rotor'),
    ('rotor_size',      '203mm',            '203mm disc brake rotor'),
    ('rotor_size',      '160mm',            '160mm disc brake rotor'),
    ('steerer',         'Tapered 1.5"',     'Tapered steerer tube: 1-1/8" to 1.5"'),
    ('steerer',         'Straight 1-1/8"',  'Straight 1-1/8" steerer tube'),
    ('front_axle',      'Boost 110x15',     'Boost front hub: 110mm OLD, 15mm thru-axle'),
    ('front_axle',      'Standard 100x15',  'Standard front hub: 100mm OLD, 15mm thru-axle');

-- ============================================================
-- Frames
-- ============================================================
INSERT INTO frames (brand, model, year, notes) VALUES
    ('Santa Cruz', 'Hightower',  2024, 'Carbon frame, 145mm rear travel'),
    ('Trek',       'Fuel EX 8',  2022, 'Aluminum frame, 140mm rear travel'),
    ('Commencal',  'Meta HT AM', 2023, 'Aggressive hardtail, aluminum, 650b');

-- Frame 1: Santa Cruz Hightower standards
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (1, (SELECT id FROM standards WHERE category='wheel_size'       AND value='29"')),
    (1, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (1, (SELECT id FROM standards WHERE category='bb_standard'      AND value='BSA 73mm')),
    (1, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='31.6mm')),
    (1, (SELECT id FROM standards WHERE category='headset'          AND value='ZS44/ZS56')),
    (1, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (1, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (1, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- Frame 2: Trek Fuel EX standards
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (2, (SELECT id FROM standards WHERE category='wheel_size'       AND value='29"')),
    (2, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (2, (SELECT id FROM standards WHERE category='bb_standard'      AND value='PF92')),
    (2, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='34.9mm')),
    (2, (SELECT id FROM standards WHERE category='headset'          AND value='IS42/IS52')),
    (2, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (2, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (2, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- Frame 3: Commencal Meta HT (27.5)
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (3, (SELECT id FROM standards WHERE category='wheel_size'       AND value='27.5"')),
    (3, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (3, (SELECT id FROM standards WHERE category='bb_standard'      AND value='BSA 73mm')),
    (3, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='31.6mm')),
    (3, (SELECT id FROM standards WHERE category='headset'          AND value='ZS44/ZS56')),
    (3, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (3, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (3, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- ============================================================
-- Bikes (referencing frames)
-- ============================================================
INSERT INTO bikes (name, frame_id, notes) VALUES
    ('Trail Slayer',    1, 'Primary trail bike'),
    ('Park Rig',        2, 'All-around trail bike'),
    ('Hardtail Hitter', 3, 'Aggressive hardtail for park days');

-- ============================================================
-- Components
-- ============================================================
INSERT INTO components (manufacturer, model, component_type, description) VALUES
    ('Fox',       '36 Factory GRIP2',       'fork',       '160mm travel, 29", tapered, Boost 110x15'),
    ('Fox',       'Float X2 Factory',       'shock',      'Trunnion mount rear shock, 210x55mm'),
    ('DT Swiss',  'XM 1700 Spline 29',     'rear_wheel', '29" rear wheel, Boost 148x12, 30mm inner width'),
    ('DT Swiss',  'XM 1700 Spline 29 Front','front_wheel','29" front wheel, Boost 110x15, 30mm inner width'),
    ('Maxxis',    'Minion DHF 29x2.5 WT',  'tire',       'Front tire, 3C MaxxGrip, EXO+, tubeless ready'),
    ('Maxxis',    'Dissector 29x2.4 WT',   'tire',       'Rear tire, 3C MaxxTerra, EXO+, tubeless ready'),
    ('SRAM',      'GX Eagle AXS',          'drivetrain', '12-speed wireless electronic, 10-52T cassette, XD driver'),
    ('Shimano',   'XT M8120 4-Piston',     'brakes',     '4-piston hydraulic disc brake caliper, post mount'),
    ('OneUp',     'Dropper Post V2 210mm', 'seatpost',   '31.6mm diameter, 210mm travel dropper'),
    ('RockShox',  'Pike Ultimate 29',       'fork',       '140mm travel, 29", tapered, Boost 110x15'),
    ('Shimano',   'Deore M6100',           'drivetrain', '12-speed mechanical, 10-51T cassette, Micro Spline driver'),
    ('SRAM',      'Code RSC',              'brakes',     '4-piston hydraulic disc brake, post mount'),
    ('Industry Nine', 'Hydra Enduro S 27.5','rear_wheel', '27.5" rear wheel, SuperBoost 157, HG driver'),
    ('RockShox',  'Lyrik Ultimate 27.5',   'fork',       '170mm travel, 27.5", tapered, Boost 110x15'),
    ('Maxxis',    'Minion DHF 27.5x2.5 WT','tire',       '27.5" front tire, 3C MaxxGrip, DH casing'),
    ('Fox',       'Transfer Factory 34.9', 'seatpost',   '34.9mm diameter, 175mm travel dropper'),
    ('SRAM',      'Maven Ultimate',        'brakes',     '4-piston, post mount, 2300mm rear hose');

-- ============================================================
-- Component Standards linkage
-- ============================================================
INSERT INTO component_standards (component_id, standard_id) VALUES
    (1, (SELECT id FROM standards WHERE category='wheel_size'  AND value='29"')),
    (1, (SELECT id FROM standards WHERE category='steerer'     AND value='Tapered 1.5"')),
    (1, (SELECT id FROM standards WHERE category='front_axle'  AND value='Boost 110x15'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (3, (SELECT id FROM standards WHERE category='wheel_size'    AND value='29"')),
    (3, (SELECT id FROM standards WHERE category='rear_spacing'  AND value='Boost 148x12')),
    (3, (SELECT id FROM standards WHERE category='hub_driver'    AND value='Shimano MS'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (4, (SELECT id FROM standards WHERE category='wheel_size'  AND value='29"')),
    (4, (SELECT id FROM standards WHERE category='front_axle'  AND value='Boost 110x15'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (5, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (6, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (7, (SELECT id FROM standards WHERE category='hub_driver' AND value='SRAM XD'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (8, (SELECT id FROM standards WHERE category='brake_mount' AND value='Post Mount'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (9, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='31.6mm'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (10, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"')),
    (10, (SELECT id FROM standards WHERE category='steerer'    AND value='Tapered 1.5"')),
    (10, (SELECT id FROM standards WHERE category='front_axle' AND value='Boost 110x15'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (11, (SELECT id FROM standards WHERE category='hub_driver' AND value='Shimano MS'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (12, (SELECT id FROM standards WHERE category='brake_mount' AND value='Post Mount'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (13, (SELECT id FROM standards WHERE category='wheel_size'   AND value='27.5"')),
    (13, (SELECT id FROM standards WHERE category='rear_spacing' AND value='SuperBoost 157')),
    (13, (SELECT id FROM standards WHERE category='hub_driver'   AND value='Shimano HG'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (14, (SELECT id FROM standards WHERE category='wheel_size' AND value='27.5"')),
    (14, (SELECT id FROM standards WHERE category='steerer'    AND value='Tapered 1.5"')),
    (14, (SELECT id FROM standards WHERE category='front_axle' AND value='Boost 110x15'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (15, (SELECT id FROM standards WHERE category='wheel_size' AND value='27.5"'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (16, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='34.9mm'));

INSERT INTO component_standards (component_id, standard_id) VALUES
    (17, (SELECT id FROM standards WHERE category='brake_mount' AND value='Post Mount'));

-- ============================================================
-- Bike Components (install history)
-- ============================================================
INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (1, 1,  'Fork',        '2024-03-15', NULL, 1099.00, 'New, factory fresh'),
    (1, 2,  'Rear Shock',  '2024-03-15', NULL, 579.00,  'New'),
    (1, 3,  'Rear Wheel',  '2024-03-15', NULL, 649.00,  'New'),
    (1, 4,  'Front Wheel', '2024-03-15', NULL, 599.00,  'New'),
    (1, 5,  'Front Tire',  '2024-03-15', NULL, 72.00,   'New'),
    (1, 6,  'Rear Tire',   '2024-03-15', NULL, 72.00,   'New'),
    (1, 7,  'Drivetrain',  '2024-03-15', NULL, 784.00,  'New, AXS wireless'),
    (1, 8,  'Brakes',      '2024-06-01', NULL, 249.00,  'Upgraded from Deore');

INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (1, 9,  'Seatpost',    '2024-03-15', '2024-09-01', 209.00, 'Moved to hardtail');

INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (2, 10, 'Fork',        '2022-08-01', NULL, 949.00,  'Purchased used, good condition'),
    (2, 11, 'Drivetrain',  '2022-08-01', NULL, 320.00,  'Budget-friendly option'),
    (2, 12, 'Brakes',      '2022-08-01', NULL, 398.00,  'Powerful 4-piston'),
    (2, 16, 'Seatpost',    '2022-08-01', NULL, 399.00,  '34.9mm for Trek frame');

INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (3, 14, 'Fork',        '2023-05-10', NULL, 899.00,  'New'),
    (3, 15, 'Front Tire',  '2023-05-10', NULL, 72.00,   'DH casing for park days'),
    (3, 9,  'Seatpost',    '2024-09-01', NULL, 0.00,    'Transferred from Hightower'),
    (3, 17, 'Brakes',      '2023-05-10', NULL, 464.00,  'New Maven Ultimate');

-- ============================================================
-- Inventory (spare parts not installed)
-- ============================================================
INSERT INTO inventory (component_id, condition, intended_bike_id, notes) VALUES
    (13, 'Like New', 3, 'SuperBoost 157 wheel - check compatibility before installing on hardtail'),
    (6,  'Used',     NULL, 'Spare Dissector tire from Hightower tire swap');
