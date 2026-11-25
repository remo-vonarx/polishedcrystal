#!/usr/bin/env python3
"""Check the German name tables against Upstream's English.

Usage: python3 -I utils/check_names.py [--base REV] [--text [PATH ...]]

Each table in TABLES is paired by position with the same table in Upstream's
English, read with `git show` from the last merged Upstream commit
(`git merge-base HEAD upstream/master`, or --base REV).

Default run: checks the tables.
- In a table listed in GERMAN_TABLES (the name chunks add theirs), an entry
  still equal to its English is reported, unless the name is the same in both
  languages in that table (SAME_IN_GERMAN). Other tables are still English.
- Every table: an entry wider than its table's limit is reported, counted in
  tiles as check_text_width.py counts them ("#" is 4 tiles, "#mon" 7, ...).
  A limit is never below what the entry's own English takes: Upstream ships it.
- Place names (data/maps/landmarks.asm) are measured against every screen
  that shows them (place_problems): at most 18 bytes, the break marks
  included, for the 19-byte script buffers; on one line, with "¯" as a space
  and <SHY> and <WBR> as nothing, at most 18 tiles (the sign), 17 for a place
  with Johto grass Pokémon (Oak's radio show adds a "."), 16 for a flypoint
  (Fly); on the Pokégear and Town Map at most two lines of 11 tiles, split at
  "¯", <WBR> or <SHY>, which adds a "-".
- Trainer classes fit their 12-byte buffer ("#" and "#mon" are one byte each)
  and the phone list's 14 tiles.
- Trainers (data/trainers/parties.asm) are measured against the battle line
  (trainer_pairs): the German class of each def_trainer, a space and the name,
  at most 18 tiles, with <RIVAL> as 7.
- Battle Tower names (data/battle_tower/classes.asm) fit 9 tiles and are
  measured the same way (tower_pairs), with the Battle Tower's short class
  where data/battle_tower/short_class_names.asm has one; a short class fits
  12 bytes. The list counts as kept in English, except Palmer and Thorton.
- Wonder Trade names (data/events/wonder_trade/ot_names.asm) fit 7 tiles.
- Psychic Inver's name (data/trainers/psychic_inver.asm) is the name his
  party picker counts (INVER_PREFIX), and wInverGroup holds that prefix
  (inver_problems).
- Badge names fit the 18 bytes of wStringBuffer4 (Script_givebadge copies
  them there); the line they're printed on (_ReceivedTheBadgeText) depends on
  its German wording and is the badges' chunk's to check.
- A table whose German and English entry counts differ is reported, and so
  is a table that can't be found: a missing file, no entries, or a missing
  start or end label (as after an Upstream rename).

--text: lists English names left in string literals under the given paths
(default: maps/, data/, engine/ and home/). Of the trainers it knows the class
names and the named characters (named_trainers), not generic trainers' names,
which are often short everyday words. Comments and SECTION, INCLUDE
and INCBIN lines are skipped, and so is anything inside <...> tokens. Names
match as whole words (umlauts count as letters), case-sensitively, longest
first.

Exits with status 1 if anything is reported, and 2 if the check can't run:
no git, no English base, or a --text path that doesn't exist.
"""

import argparse
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from check_text_width import string_width, strip_comment  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_PATHS = ('maps', 'data', 'engine', 'home')
UPSTREAM = 'upstream/master'

RAWCHAR = re.compile(r'^\s*rawchar "([^"]*)"')
LABEL_RAWCHAR = re.compile(r'^\w+:\s+rawchar "([^"]*)"')
LABEL_DB = re.compile(r'^\w+:\s+db "([^"]*)"')
LOCAL_DB = re.compile(r'^\.\w+:\s+db "([^"]*)"')
LI = re.compile(r'^\s*li "([^"]*)"')
DB = re.compile(r'^\s+db "([^"]*)"')
TRAINER_NAME = re.compile(r'^\s*def_trainer [^,]+, "([^"]*)"')
NICKNAME = re.compile(r'^\s*tr_mon \d+, "([^"]*)"')
TRADE_NICKNAME = re.compile(r'^\s*rawchar "([^"]*)"\s*$')
TRADE_OT = re.compile(r'^\s*rawchar "([^"]*)", \$00')
PHONE_LINE = re.compile(r'^\s*(?:text|next1)\s+"([^"]*)"')

PLACE = 'place'
PLACE_BYTES = 18  # STRING_BUFFER_LENGTH - 1: scripts copy place names into 19-byte buffers
POKEGEAR_LINE = 11
PLACE_BREAK = re.compile(r'(¯|<SHY>|<WBR>)')  # place-name break marks (constants/charmap.asm)

TRAINER = 'trainer'
CLASS = 'class'
CLASS_BYTES = 12  # TRAINER_CLASS_NAME_LENGTH - 1: the class buffer (wOTClassName)
CLASS_TILES = 14  # the phone list prints the class from column 5 to 18
NAME_LENGTH = 10  # NAME_LENGTH - 1
BATTLE_LINE = 18  # "<CLASS> <NAME>" starts the battle box's first line (PlaceEnemysName)
TOWER = 'tower'
TOWER_NAME = 9  # NAME_LENGTH - 2: a full Battle Tower name has no terminator
TOWER_CLASSES = 'data/battle_tower/short_class_names.asm'
TOWER_TRAINER = re.compile(r'^\s*rawchar "([^"]*)",\s*(\w+)')
SHORT_CLASS = re.compile(r'^\s*db (\w+),\s*"([^"]*)"')

# path, entry pattern, first label (None: file start), label that ends the
# table (None: file end), limit in tiles, text category (None: tables only),
# key into SAME_IN_GERMAN
TABLES = [
    ('data/pokemon/names.asm', RAWCHAR, None, None, 10, 'mon', 'pokemon'),
    ('data/types/names.asm', LABEL_DB, 'Normal', 'Monster', 8, None, 'types'),
    ('data/types/names.asm', LABEL_DB, 'Monster', None, 12, None, 'egg groups'),
    ('data/abilities/names.asm', LABEL_RAWCHAR, None, None, 16, None, 'abilities'),
    ('data/natures.asm', LOCAL_DB, 'NatureNames', 'NatureIndicators', 7, None, 'natures'),
    ('data/moves/names.asm', LI, None, None, 12, 'move', 'moves'),
    ('data/items/names.asm', LI, None, None, 12, 'item', 'items'),
    ('data/items/key_names.asm', LI, None, None, 12, 'item', 'key items'),
    ('data/items/apricorn_names.asm', LI, None, None, 12, 'item', 'apricorns'),
    ('data/items/exp_candy_names.asm', LI, None, None, 12, 'item', 'exp candy'),
    ('data/items/special_names.asm', LI, None, None, 12, 'item', 'pokegear'),
    ('data/items/wing_names.asm', LI, None, None, 12, 'item', 'wings'),
    # the decoration menu and the text buffers (STRING_BUFFER_LENGTH - 1 = 18); the longest has 17
    ('data/decorations/names.asm', LI, None, None, 17, None, 'decorations'),
    # Script_givebadge copies the name into wStringBuffer4 (STRING_BUFFER_LENGTH - 1)
    ('data/events/badge_names.asm', LI, None, None, PLACE_BYTES, None, 'badges'),
    # a pocket name is printed on a text line of its own ("… in / <POCKET>.")
    ('data/items/pocket_names.asm', DB, 'ItemPocketNames', None, 14, None, 'pockets'),
    # the limit PLACE measures each name against its screens (place_problems)
    ('data/maps/landmarks.asm', LABEL_RAWCHAR, None, None, PLACE, 'place', 'places'),
    # Fly's prompt and its own short form of the Pokémon League Gate: 16 tiles
    ('engine/pokegear/pokegear.asm', DB, 'Where', 'Name', 16, None, 'fly'),
    ('engine/pokegear/pokegear.asm', RAWCHAR, 'PokemonLeagueFlyName', 'GetMapCursorCoordinates', 16, 'place', 'fly'),
    # the summary's place of capture when it isn't a landmark: column 1 to 19
    ('engine/pokemon/summary/orange_page.asm', DB, 'battle_factory', 'TN_PrintLV', 19, 'place', 'summary'),
    # 12 bytes ("#mon" is one) and 14 tiles (name_bytes, CLASS_TILES)
    ('data/trainers/class_names.asm', LI, None, None, CLASS, 'class', 'classes'),
    # 10 tiles each, and each class + name pair against the battle line (trainer_pairs)
    ('data/trainers/parties.asm', TRAINER_NAME, None, None, TRAINER, 'person', 'trainers'),
    ('data/trainers/parties.asm', NICKNAME, None, None, 10, None, 'nicknames'),
    # Psychic Inver's own party file: his name must also be the one INVER_PREFIX counts (inver_problems)
    ('data/trainers/psychic_inver.asm', TRAINER_NAME, None, None, NAME_LENGTH, 'person', 'trainers'),
    # 9 tiles each, and each class + name pair against the battle line (tower_pairs)
    ('data/battle_tower/classes.asm', RAWCHAR, None, None, TOWER, None, 'tower'),
    ('data/events/wonder_trade/ot_names.asm', RAWCHAR, None, None, 7, None, 'wonder trade'),
    ('data/events/npc_trades.asm', TRADE_NICKNAME, None, None, 10, None, 'trades'),
    ('data/events/npc_trades.asm', TRADE_OT, None, None, 7, 'person', 'trades'),
    # the Pokégear's phone list: columns 2 to 18
    ('data/phone/non_trainer_names.asm', PHONE_LINE, None, None, 17, None, 'phone'),
    ('engine/events/specials.asm', RAWCHAR, 'DefaultRivalName', 'SpecialTrendyPhrase', 7, None, 'rival'),
    ('engine/menus/intro_menu.asm', DB, 'Ralph', 'InitializeNPCNames', 10, None, 'ralph'),
]



# Tables whose entries must be German: each name chunk adds the keys (last column of TABLES) it
# translates. A table not listed is still English and is checked only for its limits.
GERMAN_TABLES = {'pokemon', 'types', 'egg groups', 'abilities', 'natures',  # chunk 1
                 'moves',  # chunk 2
                 'items', 'key items', 'apricorns', 'exp candy', 'wings', 'pockets',  # chunk 3
                 'classes', 'trainers', 'nicknames', 'trades', 'tower', 'wonder trade', 'rival', 'ralph',  # chunk 4
                 'places', 'badges', 'fly', 'summary',  # chunk 5
                 'pokegear', 'decorations'}  # chunk 6

# official names that are the same in English and German, and placeholders,
# per table: a name allowed in one table is still reported in another
SAME_IN_GERMAN = {
    'pokemon': {
        '?000?', '?256?',
        'Abra', 'Aerodactyl', 'Ampharos', 'Arbok', 'Ariados', 'Azumarill', 'Azurill',
        'Celebi', 'Ditto', 'Donphan', 'Dratini', 'Elekid', 'Entei', 'Farigiraf',
        'Gengar', 'Girafarig', 'Golbat', 'Granbull', 'Ho-Oh', 'Hoothoot', 'Hypno',
        'Kabuto', 'Kabutops', 'Kadabra', 'Kingler', 'Krabby', 'Lanturn', 'Lapras',
        'Larvitar', 'Ledian', 'Ledyba', 'Lugia', 'Magby', 'Magcargo', 'Magmar',
        'Magneton', 'Magnezone', 'Marill', 'Mew', 'Miltank', 'Natu', 'Nidoking',
        'Nidoqueen', 'Nidoran♀', 'Nidoran♂', 'Nidorina', 'Nidorino', 'Octillery',
        'Onix', 'Paras', 'Phanpy', 'Pichu', 'Pikachu', 'Pinsir', 'Porygon',
        'Porygon-Z', 'Porygon2', 'Pupitar', 'Raichu', 'Raikou', 'Remoraid',
        'Snubbull', 'Starmie', 'Suicune', 'Tangela', 'Tauros', 'Teddiursa',
        'Togekiss', 'Togepi', 'Togetic', 'Ursaluna', 'Ursaring', 'Vulpix', 'Xatu',
        'Yanma', 'Yanmega', 'Zapdos', 'Zubat',
    },
    'types': {'Normal', '???'},
    'egg groups': {'Monster', 'Mineral', 'Ditto'},
    'abilities': {'---', 'Chlorophyll', 'Download', 'Filter', 'Hydration', 'Insomnia'},
    'natures': {'---', 'Mild'},
    'moves': {'Blizzard', 'Explosion', 'Octazooka', 'Tackle', 'Teleport', 'Whirlpool'},
    'items': {'Lucky Punch', 'Magnet', 'Mulch', 'Nugget', 'Protein', 'Upgrade'},
    'key items': {'SilphScope2'},
    'apricorns': set(),
    'exp candy': set(),
    'pokegear': {'#dex'},
    'wings': set(),
    'decorations': {'GameCube', 'Nintendo 64', 'Pikachu', 'Super NES', 'Wii'},
    'badges': set(),
    'pockets': set(),
    'places': {'?', 'Indigo¯Plateau'} | {f'Route {n}' for n in range(1, 50)},
    'fly': set(),
    'summary': set(),
    # chunk 4: classes and names that stay as Upstream writes them (Kristall's or official German
    # names that are the same, kept English names, references); the review is in GLOSSARY.md (Trainers)
    'classes': {
        '#fan', '#mon Prof.', 'Agent', 'Boss', 'Camper', 'Cosplayer', 'Cowgirl', 'Gentleman', 'Jessie', 'Lady',
        'Medium', 'Rocket', 'Student', 'Surfer', 'Veteran'
    },
    'trainers': {
        '& James', '<RIVAL>', 'Abigail', 'Adam', 'Aegon', 'Aidan', 'Alfie', 'Alina', 'Alison', 'Allan',
        'Amanda', 'Ami', 'Amos', 'Amy', 'Anabel', 'Annie', 'April', 'Arden', 'Armand', 'Ashe', 'Ashley',
        'Barkhorn', 'Beatrice', 'Becky', 'Biff', 'Bill', 'Blaise', 'Blanche', 'Brett', 'Bruno', 'Bryony',
        'Camden', 'Camus', 'Candela', 'Carl', 'Carrie', 'Chaz', 'Chelsie', 'Chester', 'Chiara', 'Chloe',
        'Cindy', 'Clara', 'Connor', 'Conrad', 'Corey', 'Coryn', 'Craig', 'Cyd', 'Cynthia', 'Dahlia', 'Daniela',
        'Daric', 'Dennett', 'Dent', 'Derrick', 'Dexter', 'Diane', 'Dirk', 'Duplica', 'Dylan', 'Elijah', 'Eliza',
        'Emy', 'En', 'Enzo', 'Erik&Sara', 'Erika', 'Esther', 'Euna', 'Ezekiel', 'Ezra', 'Faith', 'Felix',
        'Fergus', 'Finch', 'Floyd', 'Foote', 'Frank', 'Gareth', 'Geddy', 'Geoffrey', 'Gerald', 'Gerard', 'Gina',
        'Giovanni', 'Glyn', 'Graden', 'Grady', 'Gustav', 'Hall', 'Hari', 'Heather', 'Henri', 'Holly', 'Howard',
        'Hugo', 'Imakuni', 'Imogen', 'Inigo', 'Ioana', 'Iris', 'Irving', 'Isabel', 'Ivy', 'Jacky', 'Jaime',
        'Jamie', 'Janet', 'Jaska', 'Jay', 'Jennifer', 'Joanne', 'Jones', 'Jonet', 'Jordan', 'Joseph', 'Joy',
        'Julian', 'Kagami', 'Kai', 'Kamila', 'Kathryn', 'Kazu', 'Keiko', 'Kenta', 'Kieran', 'Kinsey', 'Koga',
        'Kouta', 'Kukui', 'Kuroko', 'Lang', 'Lawrence', 'Layla', 'Lenie', 'Leon', 'Lester', 'Lily', 'Litvyak',
        'Lorelei', 'Lou', 'Louis', 'Lucas', 'Luis', 'Luna', 'Lyra', 'Lyric', 'Madoka', 'Mako', 'Malcolm',
        'Mara', 'Margaret', 'Maria', 'Marina', 'Marlene', 'Matilda', 'Matthew', 'Mavis', 'Max', 'Maynard',
        'Mayu', 'Meadow', 'Mei', 'Michel', 'Mick', 'Miguel', 'Mina', 'Miriam', 'Misty', 'Molly', 'Morgan',
        'Nadar', 'Natalie', 'Neesha', 'Nicolas', 'Nicole', 'Nigel', 'Noelle', 'Nolan', 'Nozomi', 'Oleg', 'Olga',
        'Oliver', 'Oscar', 'Oskar', 'Oswald', 'Padma', 'Paul', 'Peony', 'Pete', 'Petrie', 'Petry', 'Pierce',
        'Pierre', 'Pilar', 'Piotr', 'Powell', 'Quentin', 'Rachel', 'Ray', 'Reilly', 'Reina', 'Remy', 'Rin',
        'Roger', 'Romeo', 'Ronda', 'Rory', 'Rose', 'Rosie', 'Ruth', 'Rylan', 'Sabrina', 'Salim', 'Sally',
        'Sanders', 'Sara&Erik', 'Sarah', 'Sasha', 'Seamus', 'Sera', 'Serena', 'Sharyn', 'Smith', 'Sophie',
        'Spark', 'Stefan', 'Subaru', 'Takeo', 'Tala', 'Tamara', 'Teddy', 'Theresa', 'Tobin', 'Tony', 'Trent',
        'Tyrone', 'Uri', 'Valencia', 'Valerie', 'Victor', 'Vince', 'Viola', 'Vivian', 'Wanda', 'Winifred',
        'Winston', 'Woda', 'Zane'
    },
    'nicknames': {
        'Antorcha', 'Audrey', 'Bruce', 'Bulbasaur', 'Chuchu', 'Dopefish', 'Gold', 'Huesitos', 'Jackie', 'Lady',
        'Linterna', 'Luna', 'Milky', 'Puka', 'Teddy', 'VuiVui'
    },
    'trades': {
        'Batty', 'Chance', 'Clarence', 'Gail', 'Hari', 'Jacques', 'Jeeves', 'Joey', 'Kim', 'Mimic', 'Tim'
    },
    # the Battle Tower keeps its reference names, the Wonder Trade the names without an official
    # German one of 7 letters or fewer
    'tower': {
        'Abdul', 'Abed', 'Adam', 'Adrian', 'Alice', 'Alisha', 'Amelia', 'Andre', 'Angelica', 'Annie', 'Argo',
        'Armstrong', 'Axl', 'Bisom', 'Blake', 'Buckley', 'Charlie', 'Chelsea', 'Chiyo', 'Cobb', 'Collins',
        'Corey', 'Cramer', 'Daniel', 'Daryl', 'Deedee', 'Dennett', 'Diaz', 'Dijkstra', 'Dorothy', 'Douglas',
        'Drake', 'Dyrland', 'Ebony', 'Eleni', 'Emily', 'Estée', 'Ethel', 'Fagin', 'Frida', 'Frost', 'Garrett',
        'Gerald', 'Gwen', 'Hamilton', 'Hare', 'Hatcher', 'Heinlen', 'Hill', 'Hiroto', 'Hitesh', 'Holmes',
        'Hong', 'Hopper', 'Hughes', 'Ichigo', 'James', 'Joan', 'Joanna', 'Johnson', 'Jorge', 'Kafuka', 'Kim',
        'Kirby', 'Kubrick', 'Kuroki', 'Laura', 'Lavigne', 'Lenie', 'Mako', 'Marc', 'Mateo', 'McManus', 'Molly',
        'Monica', 'Mordecai', 'Mori', 'Morse', 'Mott', 'Mozi', 'Murray', 'Nadia', 'Nerai', 'Newandyke',
        'Newman', 'Newton', 'Nimue', 'Oakley', 'Park', 'Patricia', 'Paul', 'Phelps', 'Pirsig', 'Pitt', 'Pov',
        'Raine', 'Rajan', 'Rebecca', 'Remy', 'Ricky', 'Sagan', 'Salim', 'Santiago', 'Sawyer', 'Scipio',
        'Shirley', 'Sidney', 'Siegfried', 'Sophia', 'Suh', 'Sunni', 'Swartz', 'Syd', 'Tara', 'Tatiana',
        'Tomoyo', 'Toshi', 'Uri', 'Vi', 'Walter', 'Wayne', 'Wilder', 'Wong', 'Yayoi', 'York', 'Yufune', 'Zeke'
    },
    'wonder trade': {
        'A', 'A.J.', 'Abe', 'Aizawa', 'Alain', 'Aliana', 'Alice', 'Alpha', 'Ami', 'Amos', 'Anabel', 'Anthea',
        'Aoooo', 'Argenta', 'Artemis', 'Arty', 'Ash', 'Assunta', 'Asuka', 'Attila', 'Aya', 'Baba', 'Babs',
        'Baoba', 'Barry', 'Bel', 'Ben', 'Bill', 'Blanche', 'Bonnie', 'Bridget', 'Brigett', 'Briney', 'Bruno',
        'Bryan', 'Buena', 'Butch', 'Cameron', 'Camila', 'Candela', 'Carrie', 'Casey', 'Cassidy', 'Cedric',
        'Celio', 'Cetsa', 'Charles', 'Charon', 'Chaz', 'Cheren', 'Cissy', 'Clara', 'Cly', 'Clyde', 'Concord',
        'Copycat', 'Courtny', 'Crystal', 'Curtis', 'Cyan', 'Cynthia', 'Dahlia', 'Daisy', 'Danny', 'Daru',
        'Daruku', 'Delia', 'Delta', 'Dexio', 'Dexter', 'Diana', 'Diantha', 'Dio', 'Dirk', 'Domino', 'Don',
        'Drayano', 'Duplica', 'Earl', 'Emma', 'Erika', 'Evan', 'Everyle', 'Felicty', 'Fredrik', 'Frieda',
        'Fuego', 'Fuji', 'Gabby', 'Gaius', 'Gary', 'Gendo', 'Gester', 'Giovani', 'Giselle', 'Gold', 'Grace',
        'Greta', 'Grimsly', 'Hala', 'Hana', 'Hapu', 'Hari', 'Haruhi', 'Haruka', 'Hayate', 'Heart', 'Helena',
        'Helios', 'Hibiki', 'Hikari', 'Hiro', 'Hisashi', 'Hlin', 'Hun', 'Imakuni', 'Itsuki', 'Ivy', 'Iwata',
        'Jacques', 'Jade', 'James', 'Jessie', 'Jimmy', 'Jojo', 'Jordan', 'Josuke', 'Jotaro', 'Joy', 'Juan',
        'Julia', 'Jun', 'Junichi', 'Jupiter', 'Kagaya', 'Kahili', 'Kaito', 'Kamon', 'Karuta', 'Kaworu', 'Kei',
        'Keira', 'Keita', 'Kersh', 'Kiawe', 'Kim', 'Kiri', 'Kloe', 'Koga', 'Koji', 'Kotone', 'Kouki', 'Kukui',
        'Kurisu', 'Kurt', 'Kyon', 'Kyouhei', 'Lambda', 'Lanette', 'Leaf', 'Len', 'Leo', 'Lexus', "Li'l D",
        'Lorelei', 'Lostele', 'Luana', 'Lucian', 'Luka', 'Luke', 'Lun', 'Luna', 'Lusamin', 'Lyra', 'Lyrra',
        'Makoto', 'Mamoru', 'Marckus', 'Mari', 'Mars', 'Masuda', 'Mateo', 'Matsuda', 'Matthew', 'Mayuri', 'Mei',
        'Meiko', 'Melanie', 'Michael', 'Miguel', 'Mikey', 'Miku', 'Mikuru', 'Minako', 'Mind', 'Miror B',
        'Misty', 'Mitsuru', 'Miyuki', 'Mohn', 'Mr.<PK><MN>', 'N', 'Nagisa', 'Nishino', 'Norman', 'Nozomi',
        'Okabe', 'Omega', 'Oota', 'Orange', 'Orville', 'Paul', 'Phil', 'Pia', 'Plumera', 'Prima', 'Pum', 'Pyro',
        'Rainer', 'Randy', 'Rangi', 'Rapp', 'Reed', 'Rei', 'Reiko', 'Remy', 'Revo', 'Rhue', 'Richie', 'Rin',
        'Rosanne', 'Rudy', 'Ruka', 'Rydel', 'Ryo', 'Ryoko', 'Ryuki', 'Sabrina', 'Saika', 'Sakura', 'Samson',
        'Samuel', 'Satoru', 'Satoshi', 'Saturn', 'Scott', 'Selene', 'Serena', 'Shigeki', 'Shigeru', 'Shinji',
        'Silktre', 'Sina', 'Slade', 'Slash', 'Sogabe', 'Sophcls', 'Sorya', 'Sosuke', 'Soul', 'Spark', 'Sparky',
        'Star', 'Stern', 'Strata', 'Suki', 'Suzuha', 'Syaoran', 'Sylvie', 'Tajiri', 'Talan', 'Tamada', 'Teala',
        'Teto', 'Tetsuya', 'Theta', 'Tierno', 'Tim', 'Todd', 'Tomoyo', 'Touko', 'Touya', 'Tracey', 'Traziun',
        'Tsuruya', 'Tupp', 'Turner', 'Ty', 'Usagi', 'Valerie', 'Viola', 'Volkner', 'Wiktrom', 'Willow', 'X',
        'Y', 'Yoshi', 'Yui', 'Yuki', 'Yuuki', 'Z', 'Zeta', 'Zetsu', 'Zinzoln', 'Zipp'
    },
    'rival': set(),
    'ralph': set(),
    # the first attempt's choices were not carried over (CLAUDE.md, Project decisions): the
    # Pokégear's chunk fills this table as the user decides
    'phone': set(),
}

# English spellings in text that differ from the tables, by category
TEXT_ALIASES = {
    'mon': {},
    'move': {},
    'item': {},
    'place': {},
    'class': {},
    'person': {},
}

SKIP_LINE = re.compile(r'^\s*(SECTION|INCLUDE|INCBIN)\b')
STRING = re.compile(r'"([^"]*)"')
TOKEN = re.compile(r'<[^>]*>')
LABEL = re.compile(r'^\.?(\w+)(?::|\s*$)')


LETTER = 'A-Za-zÄÖÜäöüé_'


class BaseError(Exception):
    pass


class EnglishMissing(Exception):
    pass


def git(*args):
    try:
        result = subprocess.run(['git', '-C', str(ROOT), *args], capture_output=True, text=True)
    except OSError as error:
        raise BaseError(f"can't run git: {error}") from None
    if result.returncode:
        raise BaseError(f'git {" ".join(args)} failed: {result.stderr.strip()}')
    return result.stdout


def read_english(base, path):
    """Upstream's English text of path at base."""
    if subprocess.run(['git', '-C', str(ROOT), 'cat-file', '-e', f'{base}:{path}'],
                      capture_output=True).returncode:
        raise EnglishMissing(path)
    return git('show', f'{base}:{path}')


def find_base(base):
    if base:
        return base
    try:
        return git('merge-base', 'HEAD', UPSTREAM).strip()
    except BaseError as error:
        raise BaseError(f"can't find the English base: {error}\n"
                        'Run `git fetch upstream`, or pass --base REV.') from None


def entries(text, pattern, first, stop):
    """Return (line number, name) for each entry of one table, @ stripped,
    and the labels of `first` and `stop` that were found."""
    found = []
    labels = set()
    inside = first is None
    for number, line in enumerate(text.splitlines(), 1):
        label = LABEL.match(line)
        if label and label.group(1) in (first, stop):
            labels.add(label.group(1))
        if label and label.group(1) == stop:
            break
        if label and label.group(1) == first:
            inside = True
        if not inside:
            continue
        match = pattern.match(line)
        if match:
            found.append((number, match.group(1).rstrip('@')))
    return found, labels


def place_rooms(root):
    """Each landmark label's one-line limit: 16 for a flypoint, 17 for a place
    with Johto grass Pokémon (Oak's show), 18 for the rest."""
    def lines(rel):
        return (root / rel).read_text(encoding='utf-8').splitlines()
    consts = []
    for line in lines('constants/landmark_constants.asm'):
        if line.startswith('DEF NUM_LANDMARKS'):
            break
        match = re.match(r'^\s*const (\w+)', line)
        if match:
            consts.append(match.group(1))
    labels = [m.group(1) for line in lines('data/maps/landmarks.asm')
              for m in [re.match(r'^\s*landmark\s+-?\d+,\s*-?\d+,\s*(\w+)', line)] if m]
    if len(consts) != len(labels):
        raise BaseError(f'{len(consts)} landmark constants, {len(labels)} landmarks')
    label_of = dict(zip(consts, labels))
    map_consts = [m.group(1) for line in lines('constants/map_constants.asm')
                  for m in [re.match(r'^\s*map_const (\w+),', line)] if m]
    map_landmarks = [m.group(1) for line in lines('data/maps/maps.asm')
                     for m in [re.match(r'^\s*map \w+,\s*\w+,\s*\w+,\s*\w+,\s*(\w+),', line)] if m]
    if len(map_consts) != len(map_landmarks):
        raise BaseError(f'{len(map_consts)} map constants, {len(map_landmarks)} maps')
    landmark_of_map = dict(zip(map_consts, map_landmarks))
    rooms = {label: 18 for label in labels}
    for line in lines('data/wild/johto_grass.asm'):
        match = re.match(r'^\s*def_grass_wildmons (\w+)', line)
        if match:
            rooms[label_of[landmark_of_map[match.group(1)]]] = 17
    for line in lines('data/maps/flypoints.asm'):
        match = re.match(r'^\s*db ([A-Z]\w*),', line)
        # Fly prints its own short form for the Pokémon League Gate (TownMapBubble)
        if match and match.group(1) != 'POKEMON_LEAGUE':
            rooms[label_of[match.group(1)]] = 16
    return rooms


def place_metrics(name):
    """(bytes, tiles on one line, [tiles per Pokégear line]) of a place name. On one line "¯" is
    a space and <SHY> and <WBR> print nothing; the Pokégear breaks the name at each of the three,
    and <SHY> ends its line with a "-"."""
    parts = PLACE_BREAK.split(name)
    lines = [parts[0]]
    for mark, text in zip(parts[1::2], parts[2::2]):
        if mark == '<SHY>':
            lines[-1] += '-'
        lines.append(text)
    one_line = name.replace('¯', ' ').replace('<SHY>', '').replace('<WBR>', '')
    return string_width(name), string_width(one_line), [string_width(line) for line in lines]


def place_problems(name, one_line_limit, english=None):
    """What keeps a place name from fitting its screens (see the docstring). Each limit is at
    least what the English name takes there."""
    nbytes, one_line, lines = place_metrics(name)
    en_bytes, en_one_line, en_lines = place_metrics(english) if english else (0, 0, [])
    byte_limit, line_limit = max(PLACE_BYTES, en_bytes), max(one_line_limit, en_one_line)
    gear_limit, gear_lines = max([POKEGEAR_LINE] + en_lines), max(2, len(en_lines))
    problems = []
    if nbytes > byte_limit:
        problems.append(f'too many bytes ({nbytes} > {byte_limit})')
    if one_line > line_limit:
        problems.append(f'too long on one line ({one_line} > {line_limit})')
    if len(lines) > gear_lines:
        problems.append('more than two Pokégear lines')
    for width in lines:
        if width > gear_limit:
            problems.append(f'Pokégear line too long ({width} > {gear_limit})')
    return problems


def name_bytes(name):
    """Bytes a name takes: a <token>, "#" and "#mon" are one byte each."""
    return len(TOKEN.sub('x', name).replace('#mon', 'x').replace('#', 'x'))


def class_names(root):
    """Each trainer class constant's German class (data/trainers/class_names.asm)."""
    def lines(rel):
        return (root / rel).read_text(encoding='utf-8').splitlines()
    consts = []
    for line in lines('constants/trainer_constants.asm'):
        if line.startswith('DEF NUM_TRAINER_CLASSES'):
            break
        match = re.match(r'^\s*trainerclass (\w+)', line)
        if match and match.group(1) != 'TRAINER_NONE':
            consts.append(match.group(1))
    names = [m.group(1) for line in lines('data/trainers/class_names.asm') for m in [LI.match(line)] if m]
    if len(consts) != len(names):
        raise BaseError(f'{len(consts)} trainer classes, {len(names)} class names')
    return dict(zip(consts, names))


def trainer_pairs(root):
    """(line number, class constant, German class, name) for every def_trainer
    in data/trainers/parties.asm."""
    def lines(rel):
        return (root / rel).read_text(encoding='utf-8').splitlines()
    class_of = class_names(root)
    pairs = []
    current = None
    for number, line in enumerate(lines('data/trainers/parties.asm'), 1):
        match = re.match(r'^\s*def_trainer_class (\w+)', line)
        if match:
            current = match.group(1)
            continue
        match = TRAINER_NAME.match(line)
        if match:
            if current not in class_of:
                raise BaseError(f'data/trainers/parties.asm:{number}: unknown trainer class {current}')
            pairs.append((number, current, class_of[current], match.group(1)))
    return pairs


def tower_short_classes(root, class_of):
    """The Battle Tower's short classes by constant, and the problems with them:
    a short class over its 12-byte buffer. No table means no short classes."""
    path = root / TOWER_CLASSES
    if not path.is_file():
        return {}, []
    shorts = {}
    problems = []
    for number, line in enumerate(path.read_text(encoding='utf-8').splitlines(), 1):
        match = SHORT_CLASS.match(line)
        if not match:
            continue
        const, short = match.group(1), match.group(2).rstrip('@')
        if const not in class_of:
            raise BaseError(f'{TOWER_CLASSES}:{number}: unknown trainer class {const}')
        if name_bytes(short) > CLASS_BYTES:
            problems.append(f'{TOWER_CLASSES}:{number}: too many bytes ({name_bytes(short)} > {CLASS_BYTES}): "{short}"')
        shorts[const] = short
    return shorts, problems


def tower_pairs(root):
    """{line number: (class shown, name)} for every Battle Tower trainer, with
    the short class where the Battle Tower has one, and the short classes'
    problems."""
    class_of = class_names(root)
    shorts, problems = tower_short_classes(root, class_of)
    pairs = {}
    path = 'data/battle_tower/classes.asm'
    for number, line in enumerate((root / path).read_text(encoding='utf-8').splitlines(), 1):
        match = TOWER_TRAINER.match(line)
        if match:
            name, const = match.group(1).rstrip('@'), match.group(2)
            if const not in class_of:
                raise BaseError(f'{path}:{number}: unknown trainer class {const}')
            pairs[number] = (shorts.get(const, class_of[const]), name)
    return pairs, problems


def named_trainers(pairs):
    """The line numbers of named characters (Falkner, Lyra): the trainers of a
    class constant that has a single name, not generic trainers. Grouped by
    constant, since constants share class names ("Leader"). Tokens such as
    <RIVAL> are left out."""
    by_class = {}
    for number, const, _, name in pairs:
        by_class.setdefault(const, {}).setdefault(name, []).append(number)
    return {number for names in by_class.values() if len(names) == 1
            for name, numbers in names.items() if not TOKEN.search(name) for number in numbers}


def check_tables(base):
    """Return (problems, {category: {English: German}})."""
    problems = []
    names = {}
    rooms = None
    trainers = None
    tower = None
    for path, pattern, first, stop, limit, category, same in TABLES:
        if not (ROOT / path).is_file():
            problems.append(f'{path}: file not found')
            continue
        try:
            english_text = read_english(base, path)
        except EnglishMissing:
            problems.append(f'{path}: not in the English base {base}')
            continue
        german, german_labels = entries((ROOT / path).read_text(encoding='utf-8'), pattern, first, stop)
        english, english_labels = entries(english_text, pattern, first, stop)
        english = [name for _, name in english]
        missing = [label for label in (first, stop) if label and label not in german_labels & english_labels]
        if missing:
            problems += [f'{path}: label "{label}" not found' for label in missing]
            continue
        if not german or not english:
            problems.append(f'{path}: no entries found')
            continue
        if len(german) != len(english):
            problems.append(f'{path}: {len(german)} German entries, {len(english)} English')
            continue
        german_lines = (ROOT / path).read_text(encoding='utf-8').splitlines()
        for (number, de), en in zip(german, english):
            if limit == PLACE:
                rooms = rooms or place_rooms(ROOT)
                label = LABEL.match(german_lines[number - 1]).group(1)
                for problem in place_problems(de, rooms.get(label, 18), en):
                    problems.append(f'{path}:{number}: {problem}: "{de}"')
            elif limit == CLASS:
                if name_bytes(de) > CLASS_BYTES:
                    problems.append(f'{path}:{number}: too many bytes ({name_bytes(de)} > {CLASS_BYTES}): "{de}"')
                if string_width(de) > CLASS_TILES:
                    problems.append(f'{path}:{number}: too long ({string_width(de)} > {CLASS_TILES}): "{de}"')
            elif limit == TRAINER:
                if trainers is None:
                    pairs = trainer_pairs(ROOT)
                    trainers = ({n: (cls, name) for n, _, cls, name in pairs}, named_trainers(pairs))
                if string_width(de) > NAME_LENGTH:
                    problems.append(f'{path}:{number}: too long ({string_width(de)} > {NAME_LENGTH}): "{de}"')
                cls, name = trainers[0][number]
                width = string_width(f'{cls} {name}')
                if width > BATTLE_LINE:
                    problems.append(f'{path}:{number}: class and name too long ({width} > {BATTLE_LINE}): "{cls} {name}"')
            elif limit == TOWER:
                if tower is None:
                    tower, short_problems = tower_pairs(ROOT)
                    problems += short_problems
                if string_width(de) > TOWER_NAME:
                    problems.append(f'{path}:{number}: too long ({string_width(de)} > {TOWER_NAME}): "{de}"')
                cls, name = tower[number]
                width = string_width(f'{cls} {name}')
                if width > BATTLE_LINE:
                    problems.append(f'{path}:{number}: class and name too long ({width} > {BATTLE_LINE}): "{cls} {name}"')
            elif string_width(de) > max(limit, string_width(en)):
                problems.append(f'{path}:{number}: too long ({string_width(de)} > {limit}): "{de}"')
            if de == en and same in GERMAN_TABLES and en not in SAME_IN_GERMAN[same]:
                problems.append(f'{path}:{number}: still English: "{de}"')
            elif category and de != en and (limit != TRAINER or number in trainers[1]):
                plain = lambda s: s.replace('¯', ' ')  # noqa: E731
                names.setdefault(category, {})[plain(en)] = plain(de)
    for category, aliases in TEXT_ALIASES.items():
        names.setdefault(category, {}).update(aliases)
    return problems, names


INVER_PARTY = 'data/trainers/psychic_inver.asm'
INVER_PICKER = 'engine/battle/pick_psychic_inver_party.asm'
INVER_RAM = 'ram/wram0.asm'


def inver_problems(root):
    """Psychic Inver's name against his party picker: PickPsychicInverParty copies
    INVER_PREFIX bytes (length, STRLEN of a name with "@", flags) into wInverGroup,
    so his name must be that name, and wInverGroup must hold the prefix."""
    def read(rel):
        return (root / rel).read_text(encoding='utf-8')
    name = re.search(r'def_trainer 1, "([^"]*)"', read(INVER_PARTY))
    prefix = re.search(r'DEF INVER_PREFIX = 1 \+ STRLEN\("([^"]*)@"\) \+ 1', read(INVER_PICKER))
    group = re.search(r'^wInverGroup::\n\tds (\d+)', read(INVER_RAM), re.M)
    if not (name and prefix and group):
        return [f'{INVER_PICKER}: Psychic Inver\'s name, INVER_PREFIX or wInverGroup not found']
    problems = []
    if name.group(1) != prefix.group(1):
        problems.append(f'{INVER_PARTY}: "{name.group(1)}" is not the name INVER_PREFIX counts ("{prefix.group(1)}")')
    size = 1 + name_bytes(prefix.group(1)) + 1 + 1
    if int(group.group(1)) < size:
        problems.append(f'{INVER_RAM}: wInverGroup\'s prefix is {group.group(1)} bytes, INVER_PREFIX copies {size}')
    return problems


def check(base=None):
    """The tables' problems, against Upstream's English at `base` (default: the merge-base)."""
    return check_tables(find_base(base))[0] + inver_problems(ROOT)


def check_text(paths, names):
    mapping = {en: de for category in names.values() for en, de in category.items()}
    patterns = [(en, mapping[en], re.compile(f'(?<![{LETTER}])' + re.escape(en) + f'(?![{LETTER}])'))
                for en in sorted(mapping, key=len, reverse=True)]
    hits = []
    files = []
    for path in paths:
        full = ROOT / path
        if not full.exists():
            raise BaseError(f'no such path: {path}')
        files.extend(sorted(full.rglob('*.asm')) if full.is_dir() else [full])
    for file in files:
        for number, line in enumerate(file.read_text(encoding='utf-8').splitlines(), 1):
            if SKIP_LINE.match(line):
                continue
            for string in STRING.findall(strip_comment(line)):
                taken = {i for token in TOKEN.finditer(string) for i in range(*token.span())}
                for en, de, pattern in patterns:
                    for match in pattern.finditer(string):
                        span = set(range(*match.span()))
                        if span & taken:
                            continue
                        taken |= span
                        hits.append(f'{file.relative_to(ROOT)}:{number}: {en} -> {de}: "{string}"')
    return hits


def main():
    parser = argparse.ArgumentParser(description='Check the German name tables.')
    parser.add_argument('--base', help=f'English base revision (default: git merge-base HEAD {UPSTREAM})')
    parser.add_argument('--text', nargs='*', metavar='PATH',
                        help='list English names left in text under PATH (default: maps data engine home)')
    args = parser.parse_args()
    try:
        problems, names = check_tables(find_base(args.base))
        if args.text is not None:
            name_problems = (': still English: ', ': too long ', ': too many bytes ', ': Pokégear line too long ',
                             ': more than two Pokégear lines', ': class and name too long ')
            problems = [p for p in problems if not any(kind in p for kind in name_problems)]
            problems += check_text(args.text or DEFAULT_PATHS, names)
    except BaseError as error:
        print(f'check_names.py: {error}', file=sys.stderr)
        return 2
    for problem in problems:
        print(problem)
    return 1 if problems else 0


if __name__ == '__main__':
    sys.exit(main())
