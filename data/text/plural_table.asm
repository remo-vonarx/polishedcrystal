	; use rawchars so `plural` can reverse strings
	setcharmap no_ngrams

MACRO plural
	for i, CHARLEN(\1)
		db STRCHAR(\1, CHARLEN(\1) - 1 - i)
	endr
	db "@", \2, "@"
ENDM

PluralTable:
	; German plurals. Order matters: the first rule whose input ends the name wins,
	; so "tasche" comes before "asche" and "weste" before "este".
	; Untranslated texts that still pluralize English words:
	plural "time",      "times"      ; HitNTimesText (battle)
	plural "minute",    "minutes"    ; Route 35 National Park Gate
	; Whole names
	plural "Ovaler Stein", "Ovale Steine"
	plural "Upgrade",   "Upgrades"
	plural "Carbon",    "Carbon"
	plural "Glücks-Ei", "Glücks-Eier"
	plural "osum",      "osa"        ; Kuriosum
	plural "on XS",     "ons XS"     ; EP-Bonbon XS
	plural "on XL",     "ons XL"
	plural "on S",      "ons S"
	plural "on M",      "ons M"
	plural "on L",      "ons L"
	; Umlaut plurals
	plural "ball",      "bälle"      ; # Balls, Rauchball
	plural "rank",      "ränke"      ; Trank, Supertrank
	plural "raut",      "räuter"     ; Vitalkraut, Mentalkraut
	plural "haut",      "häute"      ; Drachenhaut
	plural "latt",      "lätter"     ; Silberblatt
	plural "band",      "bänder"     ; Schutzband, Wahlband
	plural "ock",       "öcke"       ; Megablock
	plural "ahn",       "ähne"       ; Drachenzahn, Scharfzahn
	plural "glas",      "gläser"     ; Schattenglas
	plural "sang",      "sänge"      ; Seegesang
	plural "hang",      "hänge"      ; Tarnumhang
	plural "opf",       "öpfe"       ; Fluchtknopf
	plural "aft",       "äfte"       ; Beerensaft
	; Feminine nouns in -e take -n
	plural "tasche",    "taschen"    ; Fluchttasche
	plural "asche",     "asche"      ; Zauberasche
	plural "kohle",     "kohle"      ; Holzkohle
	plural "weste",     "westen"     ; Offens.weste
	plural "este",      "este"       ; Überreste
	plural "uhe",       "uhe"        ; Plat.schuhe
	plural "e",         "en"         ; Beeren, Perlen, Linsen, Limonaden
	; -e
	plural "tein",      "teine"      ; Steine, Proteine
	plural "Stein",     "Steine"
	plural "rief",      "riefe"      ; Briefe
	plural "Brief",     "Briefe"
	plural "ift",       "ifte"       ; Gegengift
	plural "iff",       "iffe"       ; X-Angriff
	plural "eil",       "eile"       ; Fluchtseil
	plural "urt",       "urte"       ; Gurte
	plural "ich",       "iche"       ; Giftstich
	plural "ett",       "ette"       ; Münzamulett
	plural "nom",       "nome"       ; Metronom
	plural "ith",       "ithe"       ; Evolith
	plural "elm",       "elme"       ; Beulenhelm
	plural "uh",        "uhe"        ; Boxhandschuh
	plural "itz",       "itze"       ; Kugelblitz
	plural "icht",      "ichte"      ; Machtgewicht
	plural "ück",       "ücke"       ; Sternenstück
	plural "net",       "nete"       ; Magnet
	plural "eks",       "ekse"       ; Wutkeks
	plural "ilz",       "ilze"       ; Pilze
	plural "ixier",     "ixiere"     ; Elixier
	plural "-Gen",      "-Gene"      ; Berserk-Gen
	; -en, -n, -ien, -s
	plural "ung",       "ungen"      ; Rüstung, Top-Genesung
	plural "eif",       "eifen"      ; Machtreif
	plural "zel",       "zeln"       ; Kraftwurzel
	plural "sel",       "seln"       ; Fäh.-Kapsel
	plural "gel",       "geln"       ; Eisenkugel
	plural "ossil",     "ossilien"   ; Fossilien
	plural "on",        "ons"        ; Sonderbonbon, Luftballon
	plural "Orb",       "Orbs"       ; Leben-Orb, Heiss-Orb
	plural "ugget",     "uggets"     ; Nugget
	plural "hal",       "hals"       ; Seidenschal, Wahlschal
	plural "ray",       "rays"       ; Halsspray
	plural "isc",       "iscs"       ; Dubiosdisc
	plural "ack",       "acks"       ; Hackattack
	plural "",          ""           ; everything else: -er, -el, -en, substances, abbreviations

	setcharmap default
