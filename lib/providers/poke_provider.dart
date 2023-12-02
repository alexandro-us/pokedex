import 'package:flutter/material.dart';
import 'package:pokedex/models/poke_model.dart';

class PokePovider with ChangeNotifier {

  String _sortType = 'Number';
  List<PokeListItem> _pokemons = [];
  List<PokeListItem> _pokemonsFull = [];
  List<PokeListItem> _pokemonsResults = [];

   String get sortType => _sortType;

   set sortType( String val ){
      _sortType = val;
      notifyListeners();
   }

   List<PokeListItem> get pokemons => _pokemons;

   set pokemons( List<PokeListItem> val ){
      _pokemons = val;
      notifyListeners();
   }

   List<PokeListItem> get pokemonsFull => _pokemonsFull;

    set pokemonsFull( List<PokeListItem> val ){
      _pokemonsFull = val;
      notifyListeners();
   }

   List<PokeListItem> get pokemonsResults => _pokemonsResults;

    set pokemonsResults( List<PokeListItem> val ){
      _pokemonsResults = val;
      notifyListeners();
   }

   newItems( List<PokeListItem> items) {
      _pokemons = [
        ..._pokemons,
        ...items
      ];
      notifyListeners();
   }

  void sort() {
    if(_sortType == 'Name') {
      _pokemons.sort((a, b) => a.name.compareTo(b.name));
    } else {
      _pokemons.sort((a, b) => a.id.compareTo(b.id));
    }
    notifyListeners();
  }
}