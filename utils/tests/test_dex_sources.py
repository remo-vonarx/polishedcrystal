"""Tests for dex_sources.py: where a Polished Pokédex entry's English comes from, and its German."""
import pytest


def flavor(text, lang, version):
    return {"flavor_text": text, "language": {"name": lang}, "version": {"name": version}}


MACH = [("category", "Bird"), ("text", "This #mon flies at"), ("next", "Mach 2 speed,"), ("next", "seeking prey.@")]
SPECIES = {"flavor_text_entries": [
    flavor("This POKéMON flies at\nMach 2 speed, seeking\fprey.", "en", "yellow"),
    flavor("This Pokémon flies at Mach 2 speed,\nseeking prey.", "en", "lets-go-pikachu"),
    flavor("Dieses Pokémon fliegt\nmit Mach 2.", "de", "lets-go-pikachu"),
    flavor("It spreads its beautiful wings.", "en", "silver"),
]}


def test_origin_takes_german_of_a_matching_version():
    from dex_sources import origin
    o = origin(MACH, SPECIES)
    assert (o.cls, o.versions, o.german, o.german_versions) == (
        "pokeapi", ["lets-go-pikachu", "yellow"], "Dieses Pokémon fliegt mit Mach 2.", ["lets-go-pikachu"])


def test_origin_without_german_points_to_pokewiki():
    from dex_sources import origin
    o = origin([("text", "It spreads its"), ("next", "beautiful wings.@")], SPECIES)
    assert (o.cls, o.versions, o.german) == ("pokewiki", ["silver"], None)


def test_origin_of_unknown_english_is_none():
    from dex_sources import origin
    assert origin([("text", "A wholly new entry.@")], SPECIES).cls == "none"


def test_differing_german_is_ambiguous():
    from dex_sources import origin
    species = {"flavor_text_entries": SPECIES["flavor_text_entries"] + [
        flavor("This Pokémon flies at Mach 2 speed, seeking prey.", "en", "lets-go-eevee"),
        flavor("Es fliegt mit Mach 2.", "de", "lets-go-eevee")]}
    o = origin(MACH, species)
    assert o.cls == "ambiguous" and set(o.german_versions) == {"lets-go-pikachu", "lets-go-eevee"}


def test_flavor_text_joins_soft_hyphens():
    from dex_sources import flat
    assert flat("Its outstand\xad\ning vision\fsees all.") == "Its outstanding vision sees all."


def test_species_names(root):
    from dex_sources import species_names
    names = species_names(root)
    assert names["BulbasaurPokedexEntry"] == "bulbasaur"
    assert names["MrMimePlainPokedexEntry"] == "mr-mime"
    assert names["HoOhPokedexEntry"] == "ho-oh"
    assert names["MimeJrPokedexEntry"] == "mime-jr"
    assert names["RattataAlolanPokedexEntry"] == "rattata"
    assert names["FarfetchDGalarianPokedexEntry"] == "farfetchd"
    assert names["TaurosPaldeanFirePokedexEntry"] == "tauros"


def test_shortened_entry_is_traced_as_edited():
    from dex_sources import origin
    species = {"flavor_text_entries": [
        flavor("After deflecting attacks with its hard leaf shield, it strikes back with its sharp leek "
               "stalk. The leek stalk is both weapon and food.", "en", "shield"),
        flavor("Nachdem es mit seinem Schild pariert hat, schlägt es mit seiner Lauchstange zurück.", "de", "shield")]}
    o = origin([("text", "After deflecting attacks with its hard leaf shield, it strikes back with its sharp"),
                ("next", "leek stalk.@")], species)
    assert (o.cls, o.versions, o.edited) == ("pokeapi", ["shield"], True) and o.score == 1.0


def test_crystal_match_takes_kristall():
    from dex_sources import origin
    species = {"flavor_text_entries": [
        flavor("It flits from flower to flower, collecting nectar. It can identify distant flowers.", "en", "crystal")]}
    o = origin([("text", "It flits from flower to flower, collecting nectar. It can even identify distant"),
                ("next", "flowers.@")], species)
    assert (o.cls, o.versions, o.edited) == ("kristall", ["crystal"], True)


def test_form_without_match_is_a_form(root):
    from dex_sources import form_labels
    forms = form_labels(root)
    assert "RattataAlolanPokedexEntry" in forms and "RattataPlainPokedexEntry" not in forms
