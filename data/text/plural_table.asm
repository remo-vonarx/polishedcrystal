	; use rawchars so `plural` can reverse strings
	setcharmap no_ngrams

MACRO plural
	for i, CHARLEN(\1)
		db STRCHAR(\1, CHARLEN(\1) - 1 - i)
	endr
	db "@", \2, "@"
ENDM

PluralTable:
	; Note that order matters since "uhe" is a subset of "e" for example.
	; ROM0 has no room for every ending: a name without a rule keeps its singular form.
	plural "r Stein",   " Steine"    ; Ovale Steine
	plural "ste",       "ste"        ; Überreste
	plural "uhe",       "uhe"        ; Plat.schuhe
	plural "rade",      "rades"      ; Upgrades
	plural "tet",       "ten"        ; kosten (in the Mart texts)
	plural "e",         "en"         ; Beeren, Perlen; wurden (in the PC texts), Minuten (Route 35 gate)
	plural "all",       "älle"       ; Pokébälle
	plural "ank",       "änke"       ; Tränke
	plural "raut",      "räuter"     ; Vitalkräuter
	plural "zel",       "zeln"       ; Kraftwurzeln
	plural "in",        "ine"        ; Feuersteine, Proteine
	plural "opf",       "öpfe"       ; Fluchtknöpfe
	plural "f",         "fe"         ; Briefe, X-Angriffe
	plural "lz",        "lze"        ; Riesenpilze
	plural "rt",        "rte"        ; Fokusgurte
	plural "get",       "gets"       ; Nuggets
	plural "band",      "bänder"     ; Machtbänder
	plural "ift",       "ifte"       ; Gegengifte
	plural "ier",       "iere"       ; Elixiere
	plural "eil",       "eile"       ; Fluchtseile
	plural "ück",       "ücke"       ; Sternenstücke
	plural "nbon",      "nbons"      ; Sonderbonbons
	plural "",          ""           ; everything else keeps its form (Heiler, Äther, Top-Genesung)

	setcharmap default
