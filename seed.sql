-- ============================================================
-- Standards
-- ============================================================
INSERT INTO standards (category, value, description) VALUES
    ('wheel_size',      '29"',              '29 inch (622mm BSD) wheel diameter'),
    ('wheel_size',      '27.5"',            '27.5 inch (584mm BSD) wheel diameter'),
    ('rear_spacing',    'Boost 148x12',     'Boost rear hub: 148mm OLD, 12mm thru-axle'),
    ('rear_spacing',    'SuperBoost 157x12',   'SuperBoost Plus: 157mm OLD, 12mm thru-axle'),
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
    ('Santa Cruz', 'Hightower',               2024, 'Carbon CC frame, 145mm rear travel, VPP suspension'),
    ('Trek',       'Fuel EX 8',               2022, 'Aluminum frame, 140mm rear travel, ABP suspension'),
    ('Commencal',  'Meta HT AM',              2023, 'Aggressive hardtail, aluminum, 650b only'),
    ('Specialized','Stumpjumper EVO Expert',   2024, 'FACT 11m carbon, 150mm rear travel, adjustable geometry'),
    ('Yeti',       'SB150',                   2023, 'Carbon, 150mm rear travel, Switch Infinity suspension'),
    ('Canyon',     'Spectral 29 CF',          2024, 'Carbon, 150mm rear travel, Triple Phase suspension'),
    ('Nukeproof',  'Mega 290',                2023, 'Aluminum, 170mm rear travel, enduro race geometry'),
    ('Transition', 'Sentinel V3',             2024, 'Carbon, 140mm rear travel, GiddyUp suspension platform'),
    ('Ibis',       'Ripmo V2S',               2023, 'Carbon, 147mm rear travel, DW-Link suspension');

-- Frame 1: Santa Cruz Hightower
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (1, (SELECT id FROM standards WHERE category='wheel_size'       AND value='29"')),
    (1, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (1, (SELECT id FROM standards WHERE category='bb_standard'      AND value='BSA 73mm')),
    (1, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='31.6mm')),
    (1, (SELECT id FROM standards WHERE category='headset'          AND value='ZS44/ZS56')),
    (1, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (1, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (1, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- Frame 2: Trek Fuel EX 8
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

-- Frame 4: Specialized Stumpjumper EVO Expert (BSA 73mm, 34.9mm seatpost)
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (4, (SELECT id FROM standards WHERE category='wheel_size'       AND value='29"')),
    (4, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (4, (SELECT id FROM standards WHERE category='bb_standard'      AND value='BSA 73mm')),
    (4, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='34.9mm')),
    (4, (SELECT id FROM standards WHERE category='headset'          AND value='ZS44/ZS56')),
    (4, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (4, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (4, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- Frame 5: Yeti SB150 (BSA 73mm, 30.9mm seatpost)
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (5, (SELECT id FROM standards WHERE category='wheel_size'       AND value='29"')),
    (5, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (5, (SELECT id FROM standards WHERE category='bb_standard'      AND value='BSA 73mm')),
    (5, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='30.9mm')),
    (5, (SELECT id FROM standards WHERE category='headset'          AND value='ZS44/ZS56')),
    (5, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (5, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (5, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- Frame 6: Canyon Spectral 29 CF (BSA 73mm, 30.9mm seatpost)
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (6, (SELECT id FROM standards WHERE category='wheel_size'       AND value='29"')),
    (6, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (6, (SELECT id FROM standards WHERE category='bb_standard'      AND value='BSA 73mm')),
    (6, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='30.9mm')),
    (6, (SELECT id FROM standards WHERE category='headset'          AND value='ZS44/ZS56')),
    (6, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (6, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (6, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- Frame 7: Nukeproof Mega 290 (BSA 73mm, 31.6mm seatpost)
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (7, (SELECT id FROM standards WHERE category='wheel_size'       AND value='29"')),
    (7, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (7, (SELECT id FROM standards WHERE category='bb_standard'      AND value='BSA 73mm')),
    (7, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='31.6mm')),
    (7, (SELECT id FROM standards WHERE category='headset'          AND value='ZS44/ZS56')),
    (7, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (7, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (7, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- Frame 8: Transition Sentinel V3 (BSA 73mm, 30.9mm seatpost)
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (8, (SELECT id FROM standards WHERE category='wheel_size'       AND value='29"')),
    (8, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (8, (SELECT id FROM standards WHERE category='bb_standard'      AND value='BSA 73mm')),
    (8, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='30.9mm')),
    (8, (SELECT id FROM standards WHERE category='headset'          AND value='ZS44/ZS56')),
    (8, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (8, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (8, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- Frame 9: Ibis Ripmo V2S (BSA 73mm, 30.9mm seatpost)
INSERT INTO frame_standards (frame_id, standard_id) VALUES
    (9, (SELECT id FROM standards WHERE category='wheel_size'       AND value='29"')),
    (9, (SELECT id FROM standards WHERE category='rear_spacing'     AND value='Boost 148x12')),
    (9, (SELECT id FROM standards WHERE category='bb_standard'      AND value='BSA 73mm')),
    (9, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='30.9mm')),
    (9, (SELECT id FROM standards WHERE category='headset'          AND value='ZS44/ZS56')),
    (9, (SELECT id FROM standards WHERE category='brake_mount'      AND value='Post Mount')),
    (9, (SELECT id FROM standards WHERE category='steerer'          AND value='Tapered 1.5"')),
    (9, (SELECT id FROM standards WHERE category='front_axle'       AND value='Boost 110x15'));

-- ============================================================
-- Bikes (referencing frames)
-- ============================================================
INSERT INTO bikes (name, frame_id, notes) VALUES
    ('Trail Slayer',    1, 'Primary trail bike'),
    ('Park Rig',        2, 'All-around trail bike'),
    ('Hardtail Hitter', 3, 'Aggressive hardtail for park days'),
    ('Enduro Weapon',   4, 'Enduro race bike, built for speed'),
    ('Infinity Link',   5, 'Long-travel trail weapon'),
    ('Canyon Sender',   6, 'Do-it-all trail bike'),
    ('Mega Shred',      7, 'Enduro sled for steep and rough terrain');

-- ============================================================
-- Components
-- ============================================================
INSERT INTO components (manufacturer, model, component_type, description) VALUES
    -- Forks (1-3 existing, 18-20 new)
    ('Fox',       '36 Factory GRIP2',          'fork',       '160mm travel, 29", tapered steerer, Boost 110x15'),
    ('Fox',       'Float X2 Factory',          'shock',      'Trunnion mount rear shock, 210x55mm'),
    ('DT Swiss',  'XM 1700 Spline 29',        'rear_wheel', '29" rear wheel, Boost 148x12, 30mm inner width, Micro Spline'),
    ('DT Swiss',  'XM 1700 Spline 29 Front',  'front_wheel','29" front wheel, Boost 110x15, 30mm inner width'),
    ('Maxxis',    'Minion DHF 29x2.5 WT',     'tire',       'Front tire, 3C MaxxGrip, EXO+, tubeless ready'),
    ('Maxxis',    'Dissector 29x2.4 WT',      'tire',       'Rear tire, 3C MaxxTerra, EXO+, tubeless ready'),
    ('SRAM',      'GX Eagle AXS',             'drivetrain', '12-speed wireless electronic, 10-52T cassette, XD driver'),
    ('Shimano',   'XT M8120 4-Piston',        'brakes',     '4-piston hydraulic disc brake caliper, post mount'),
    ('OneUp',     'Dropper Post V2 210mm',    'seatpost',   '31.6mm diameter, 210mm travel dropper'),
    ('RockShox',  'Pike Ultimate 29',          'fork',       '140mm travel, 29", DebonAir+ spring, Charger 3 damper, Boost 110x15'),
    ('Shimano',   'Deore M6100',              'drivetrain', '12-speed mechanical, 10-51T cassette, Micro Spline driver'),
    ('SRAM',      'Code RSC',                 'brakes',     '4-piston hydraulic disc brake, SwingLink lever, post mount'),
    ('Industry Nine', 'Hydra Enduro S 27.5',  'rear_wheel', '27.5" rear wheel, SuperBoost 157x12, HG driver, 690 POE hub'),
    ('RockShox',  'Lyrik Ultimate 27.5',      'fork',       '170mm travel, 27.5", DebonAir+ spring, Charger 3, Boost 110x15'),
    ('Maxxis',    'Minion DHF 27.5x2.5 WT',  'tire',       '27.5" front tire, 3C MaxxGrip, DH casing'),
    ('Fox',       'Transfer Factory 34.9',    'seatpost',   '34.9mm diameter, 175mm travel dropper, Kashima coat'),
    ('SRAM',      'Maven Ultimate',           'brakes',     '4-piston, Bleeding Edge caliper, post mount, 2300mm rear hose'),
    -- New forks
    ('Fox',       '38 Factory GRIP2',          'fork',       '170mm travel, 29", 38mm stanchions, Kashima coat, Boost 110x15'),
    ('RockShox',  'ZEB Ultimate RC2',          'fork',       '170mm travel, 29", DebonAir+ spring, Charger 3 RC2 damper, Boost 110x15'),
    ('DVO',       'Diamond D1 29',             'fork',       '170mm travel, 29", OTT air spring, 4-way adjustable damper, Boost 110x15'),
    -- New shocks
    ('Fox',       'Float DPX2 Factory',        'shock',      '210x55mm trunnion mount, EVOL air spring, Kashima coat'),
    ('RockShox',  'Super Deluxe Ultimate',     'shock',      '230x60mm, DebonAir+ spring, Thru Shaft damper'),
    ('EXT',       'Storia V3',                 'shock',      '210x55mm, position-sensitive damping, HBC adjustment'),
    -- New drivetrains
    ('Shimano',   'XTR M9100 12-Speed',       'drivetrain', '12-speed, 10-51T cassette, Micro Spline, Shadow RD+'),
    ('SRAM',      'X0 Eagle T-Type AXS',      'drivetrain', '12-speed wireless transmission, 10-52T cassette, XD driver, UDH mount'),
    ('Shimano',   'XT M8100 12-Speed',        'drivetrain', '12-speed, 10-51T cassette, Micro Spline, Shadow RD+'),
    -- New brakes
    ('Hope',      'Tech 4 V4',                'brakes',     '4-piston, post mount, DOT 5.1 fluid, braided hose'),
    ('Magura',    'MT7',                       'brakes',     '4-piston, post mount, mineral oil, HC 1-finger lever'),
    ('Shimano',   'Saint M820',               'brakes',     '4-piston gravity, post mount, mineral oil, servo-wave lever'),
    -- New rear wheels
    ('DT Swiss',  'EX 1700 Spline 29',        'rear_wheel', '29" rear, Boost 148x12, 30mm inner, Ratchet EXP 36T, XD driver'),
    ('Roval',     'Traverse 29 Alloy',         'rear_wheel', '29" rear, Boost 148x12, DT Swiss internals, Micro Spline'),
    -- New front wheels
    ('DT Swiss',  'EX 1700 Spline 29 Front',  'front_wheel','29" front, Boost 110x15, 30mm inner, Ratchet EXP 36T'),
    ('Roval',     'Traverse 29 Alloy Front',   'front_wheel','29" front, Boost 110x15, DT Swiss internals'),
    -- New tires
    ('Maxxis',    'Assegai 29x2.5 WT',        'tire',       'Front tire, 3C MaxxGrip, EXO+ casing, tubeless ready'),
    ('Maxxis',    'Minion DHR II 29x2.4 WT',  'tire',       'Rear tire, 3C MaxxTerra, EXO+ casing, tubeless ready'),
    ('Continental','Kryptotal Front 29x2.4',   'tire',       'Front tire, Enduro casing, Soft compound, tubeless ready'),
    ('Schwalbe',  'Magic Mary 29x2.4',         'tire',       'Front tire, Super Trail casing, Addix Soft compound'),
    ('Vittoria',  'Mazza 29x2.4',             'tire',       'Front tire, Enduro casing, Graphene 2.0 compound'),
    -- New seatposts
    ('PNW',       'Rainier Gen 3 30.9',        'seatpost',   '30.9mm, 200mm travel, externally routed, 505mm total length'),
    ('BikeYoke',  'Revive 2.0 30.9',          'seatpost',   '30.9mm, 213mm travel, self-bleeding, 485mm insertion'),
    ('Fox',       'Transfer SL Factory 34.9',  'seatpost',   '34.9mm, 175mm travel, Kashima coat, internal routing'),
    -- New headsets
    ('Cane Creek','Hellbender 70',             'headset',    'ZS44/ZS56, sealed cartridge bearings, alloy cups'),
    ('Chris King','InSet 8',                   'headset',    'ZS44/ZS56, stainless steel bearings, made in USA'),
    -- New bottom brackets
    ('SRAM',      'DUB BSA 73mm',              'bottom_bracket', 'BSA 73mm threaded, DUB spindle interface, double-row bearings'),
    ('Shimano',   'BB-MT800',                  'bottom_bracket', 'BSA 73mm threaded, Hollowtech II interface'),
    -- Handlebars
    ('Deity',     'Copperhead 35 800mm',       'handlebar',  '35mm clamp, 800mm wide, 25mm rise, 7050 aluminum'),
    ('Renthal',   'Fatbar V2 Carbon 35',       'handlebar',  '35mm clamp, 800mm wide, 30mm rise, unidirectional carbon'),
    -- Stem
    ('OneUp',     'EDC Stem 35mm',             'stem',       '35mm clamp, 42mm reach, integrated EDC tool storage');

-- ============================================================
-- Component Standards linkage
-- ============================================================

-- Fox 36 Factory GRIP2 (1): fork
INSERT INTO component_standards (component_id, standard_id) VALUES
    (1, (SELECT id FROM standards WHERE category='wheel_size'  AND value='29"')),
    (1, (SELECT id FROM standards WHERE category='steerer'     AND value='Tapered 1.5"')),
    (1, (SELECT id FROM standards WHERE category='front_axle'  AND value='Boost 110x15'));

-- DT Swiss XM 1700 rear (3)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (3, (SELECT id FROM standards WHERE category='wheel_size'    AND value='29"')),
    (3, (SELECT id FROM standards WHERE category='rear_spacing'  AND value='Boost 148x12')),
    (3, (SELECT id FROM standards WHERE category='hub_driver'    AND value='Shimano MS'));

-- DT Swiss XM 1700 front (4)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (4, (SELECT id FROM standards WHERE category='wheel_size'  AND value='29"')),
    (4, (SELECT id FROM standards WHERE category='front_axle'  AND value='Boost 110x15'));

-- Maxxis Minion DHF 29 (5)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (5, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"'));

-- Maxxis Dissector 29 (6)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (6, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"'));

-- SRAM GX Eagle AXS (7)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (7, (SELECT id FROM standards WHERE category='hub_driver' AND value='SRAM XD'));

-- Shimano XT M8120 brakes (8)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (8, (SELECT id FROM standards WHERE category='brake_mount' AND value='Post Mount'));

-- OneUp Dropper 31.6 (9)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (9, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='31.6mm'));

-- RockShox Pike Ultimate (10)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (10, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"')),
    (10, (SELECT id FROM standards WHERE category='steerer'    AND value='Tapered 1.5"')),
    (10, (SELECT id FROM standards WHERE category='front_axle' AND value='Boost 110x15'));

-- Shimano Deore M6100 (11)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (11, (SELECT id FROM standards WHERE category='hub_driver' AND value='Shimano MS'));

-- SRAM Code RSC (12)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (12, (SELECT id FROM standards WHERE category='brake_mount' AND value='Post Mount'));

-- Industry Nine Hydra 27.5 (13)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (13, (SELECT id FROM standards WHERE category='wheel_size'   AND value='27.5"')),
    (13, (SELECT id FROM standards WHERE category='rear_spacing' AND value='SuperBoost 157x12')),
    (13, (SELECT id FROM standards WHERE category='hub_driver'   AND value='Shimano HG'));

-- RockShox Lyrik Ultimate 27.5 (14)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (14, (SELECT id FROM standards WHERE category='wheel_size' AND value='27.5"')),
    (14, (SELECT id FROM standards WHERE category='steerer'    AND value='Tapered 1.5"')),
    (14, (SELECT id FROM standards WHERE category='front_axle' AND value='Boost 110x15'));

-- Maxxis Minion DHF 27.5 (15)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (15, (SELECT id FROM standards WHERE category='wheel_size' AND value='27.5"'));

-- Fox Transfer 34.9 (16)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (16, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='34.9mm'));

-- SRAM Maven Ultimate (17)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (17, (SELECT id FROM standards WHERE category='brake_mount' AND value='Post Mount'));

-- Fox 38 Factory GRIP2 (18)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (18, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"')),
    (18, (SELECT id FROM standards WHERE category='steerer'    AND value='Tapered 1.5"')),
    (18, (SELECT id FROM standards WHERE category='front_axle' AND value='Boost 110x15'));

-- RockShox ZEB Ultimate RC2 (19)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (19, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"')),
    (19, (SELECT id FROM standards WHERE category='steerer'    AND value='Tapered 1.5"')),
    (19, (SELECT id FROM standards WHERE category='front_axle' AND value='Boost 110x15'));

-- DVO Diamond D1 (20)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (20, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"')),
    (20, (SELECT id FROM standards WHERE category='steerer'    AND value='Tapered 1.5"')),
    (20, (SELECT id FROM standards WHERE category='front_axle' AND value='Boost 110x15'));

-- Shimano XTR M9100 (24)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (24, (SELECT id FROM standards WHERE category='hub_driver' AND value='Shimano MS'));

-- SRAM X0 Eagle T-Type AXS (25)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (25, (SELECT id FROM standards WHERE category='hub_driver' AND value='SRAM XD'));

-- Shimano XT M8100 12-Speed (26)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (26, (SELECT id FROM standards WHERE category='hub_driver' AND value='Shimano MS'));

-- Hope Tech 4 V4 (27)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (27, (SELECT id FROM standards WHERE category='brake_mount' AND value='Post Mount'));

-- Magura MT7 (28)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (28, (SELECT id FROM standards WHERE category='brake_mount' AND value='Post Mount'));

-- Shimano Saint M820 (29)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (29, (SELECT id FROM standards WHERE category='brake_mount' AND value='Post Mount'));

-- DT Swiss EX 1700 rear / SRAM XD (30)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (30, (SELECT id FROM standards WHERE category='wheel_size'   AND value='29"')),
    (30, (SELECT id FROM standards WHERE category='rear_spacing' AND value='Boost 148x12')),
    (30, (SELECT id FROM standards WHERE category='hub_driver'   AND value='SRAM XD'));

-- Roval Traverse 29 rear / Micro Spline (31)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (31, (SELECT id FROM standards WHERE category='wheel_size'   AND value='29"')),
    (31, (SELECT id FROM standards WHERE category='rear_spacing' AND value='Boost 148x12')),
    (31, (SELECT id FROM standards WHERE category='hub_driver'   AND value='Shimano MS'));

-- DT Swiss EX 1700 front (32)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (32, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"')),
    (32, (SELECT id FROM standards WHERE category='front_axle' AND value='Boost 110x15'));

-- Roval Traverse 29 front (33)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (33, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"')),
    (33, (SELECT id FROM standards WHERE category='front_axle' AND value='Boost 110x15'));

-- Maxxis Assegai 29 (34)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (34, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"'));

-- Maxxis Minion DHR II 29 (35)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (35, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"'));

-- Continental Kryptotal Front 29 (36)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (36, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"'));

-- Schwalbe Magic Mary 29 (37)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (37, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"'));

-- Vittoria Mazza 29 (38)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (38, (SELECT id FROM standards WHERE category='wheel_size' AND value='29"'));

-- PNW Rainier 30.9 (39)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (39, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='30.9mm'));

-- BikeYoke Revive 30.9 (40)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (40, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='30.9mm'));

-- Fox Transfer SL 34.9 (41)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (41, (SELECT id FROM standards WHERE category='seatpost_diameter' AND value='34.9mm'));

-- Cane Creek Hellbender 70 (42)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (42, (SELECT id FROM standards WHERE category='headset' AND value='ZS44/ZS56'));

-- Chris King InSet 8 (43)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (43, (SELECT id FROM standards WHERE category='headset' AND value='ZS44/ZS56'));

-- SRAM DUB BSA 73mm (44)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (44, (SELECT id FROM standards WHERE category='bb_standard' AND value='BSA 73mm'));

-- Shimano BB-MT800 (45)
INSERT INTO component_standards (component_id, standard_id) VALUES
    (45, (SELECT id FROM standards WHERE category='bb_standard' AND value='BSA 73mm'));

-- ============================================================
-- Bike Components (install history)
-- ============================================================

-- Bike 1: Trail Slayer (Santa Cruz Hightower) - full build
INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (1, 1,  'Fork',        '2024-03-15', NULL, 1099.00, 'New, factory fresh'),
    (1, 2,  'Rear Shock',  '2024-03-15', NULL, 579.00,  'New'),
    (1, 3,  'Rear Wheel',  '2024-03-15', NULL, 649.00,  'New'),
    (1, 4,  'Front Wheel', '2024-03-15', NULL, 599.00,  'New'),
    (1, 5,  'Front Tire',  '2024-03-15', NULL, 72.00,   'New'),
    (1, 6,  'Rear Tire',   '2024-03-15', NULL, 72.00,   'New'),
    (1, 7,  'Drivetrain',  '2024-03-15', NULL, 784.00,  'New, AXS wireless'),
    (1, 8,  'Brakes',      '2024-06-01', NULL, 249.00,  'Upgraded from Deore');

-- Bike 1: removed seatpost (transferred to hardtail)
INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (1, 9,  'Seatpost',    '2024-03-15', '2024-09-01', 209.00, 'Moved to hardtail');

-- Bike 2: Park Rig (Trek Fuel EX)
INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (2, 10, 'Fork',        '2022-08-01', NULL, 949.00,  'Purchased used, good condition'),
    (2, 11, 'Drivetrain',  '2022-08-01', NULL, 320.00,  'Budget-friendly option'),
    (2, 12, 'Brakes',      '2022-08-01', NULL, 398.00,  'Powerful 4-piston'),
    (2, 16, 'Seatpost',    '2022-08-01', NULL, 399.00,  '34.9mm for Trek frame');

-- Bike 3: Hardtail Hitter (Commencal Meta HT)
INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (3, 14, 'Fork',        '2023-05-10', NULL, 899.00,  'New'),
    (3, 15, 'Front Tire',  '2023-05-10', NULL, 72.00,   'DH casing for park days'),
    (3, 9,  'Seatpost',    '2024-09-01', NULL, 0.00,    'Transferred from Hightower'),
    (3, 17, 'Brakes',      '2023-05-10', NULL, 464.00,  'New Maven Ultimate');

-- Bike 4: Enduro Weapon (Specialized Stumpjumper EVO) - full race build
INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (4, 18, 'Fork',           '2024-06-10', NULL, 1199.00, 'New, 170mm travel for enduro'),
    (4, 21, 'Rear Shock',     '2024-06-10', NULL, 549.00,  'New, tuned for 150mm frame'),
    (4, 25, 'Drivetrain',     '2024-06-10', NULL, 1280.00, 'T-Type transmission, wireless'),
    (4, 29, 'Brakes',         '2024-06-10', NULL, 390.00,  'New, gravity-rated'),
    (4, 30, 'Rear Wheel',     '2024-06-10', NULL, 449.00,  'XD driver for SRAM drivetrain'),
    (4, 32, 'Front Wheel',    '2024-06-10', NULL, 399.00,  'Matched set with rear'),
    (4, 34, 'Front Tire',     '2024-06-10', NULL, 79.00,   'Assegai MaxxGrip front'),
    (4, 35, 'Rear Tire',      '2024-06-10', NULL, 75.00,   'DHR II MaxxTerra rear'),
    (4, 41, 'Seatpost',       '2024-06-10', NULL, 429.00,  '34.9mm, Kashima coat'),
    (4, 42, 'Headset',        '2024-06-10', NULL, 55.00,   'Sealed cartridge bearings'),
    (4, 44, 'Bottom Bracket', '2024-06-10', NULL, 35.00,   'DUB interface for SRAM cranks'),
    (4, 46, 'Handlebar',      '2024-06-10', NULL, 60.00,   '800mm wide, 25mm rise'),
    (4, 48, 'Stem',           '2024-06-10', NULL, 89.00,   '35mm clamp, integrated tool storage');

-- Bike 5: Infinity Link (Yeti SB150) - full XTR build
INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (5, 19, 'Fork',           '2023-09-20', NULL, 1029.00, 'New ZEB Ultimate, 170mm'),
    (5, 22, 'Rear Shock',     '2023-09-20', NULL, 549.00,  'New, paired with Switch Infinity'),
    (5, 24, 'Drivetrain',     '2023-09-20', NULL, 1149.00, 'Full XTR groupset'),
    (5, 27, 'Brakes',         '2023-09-20', NULL, 389.00,  'Hope Tech 4, great modulation'),
    (5, 31, 'Rear Wheel',     '2023-09-20', NULL, 499.00,  'Micro Spline for XTR cassette'),
    (5, 33, 'Front Wheel',    '2023-09-20', NULL, 449.00,  'Matched Roval set'),
    (5, 36, 'Front Tire',     '2023-09-20', NULL, 69.00,   'Kryptotal, great cornering grip'),
    (5, 37, 'Rear Tire',      '2023-09-20', NULL, 65.00,   'Magic Mary, fast rolling'),
    (5, 40, 'Seatpost',       '2023-09-20', NULL, 349.00,  'BikeYoke self-bleeding dropper'),
    (5, 43, 'Headset',        '2023-09-20', NULL, 155.00,  'Chris King, buttery smooth'),
    (5, 45, 'Bottom Bracket', '2023-09-20', NULL, 25.00,   'Shimano BSA for Hollowtech cranks');

-- Bike 6: Canyon Sender (Spectral 29 CF) - partial build in progress
INSERT INTO bike_components (bike_id, component_id, position, install_date, removal_date, price, condition_notes) VALUES
    (6, 20, 'Fork',       '2025-02-15', NULL, 999.00,  'DVO Diamond, incredible small-bump sensitivity'),
    (6, 23, 'Rear Shock', '2025-02-15', NULL, 750.00,  'EXT Storia, position-sensitive damping');

-- Bike 7: Mega Shred (Nukeproof Mega 290) - frame only, build not started

-- ============================================================
-- Inventory (spare parts not installed)
-- ============================================================
INSERT INTO inventory (component_id, condition, intended_bike_id, notes) VALUES
    (13, 'Like New', 3,    'SuperBoost 157 wheel, check compatibility before installing on hardtail'),
    (6,  'Used',     NULL, 'Spare Dissector tire from Hightower tire swap'),
    (38, 'New',      6,    'Vittoria Mazza enduro tire, for Canyon Sender front'),
    (39, 'Like New', NULL, '30.9mm dropper, came off a friend''s bike'),
    (47, 'New',      5,    'Renthal carbon bar upgrade for Yeti build'),
    (26, 'New',      6,    'Shimano XT drivetrain, waiting for Canyon build to progress'),
    (28, 'Used',     7,    'Magura MT7 brakes, earmarked for Nukeproof Mega build');
