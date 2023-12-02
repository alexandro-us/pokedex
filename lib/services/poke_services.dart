import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/poke_model.dart';
import 'package:pokedex/models/poke_paginated_response.dart';
import 'package:pokedex/models/pokemon_response.dart';
import 'package:pokedex/providers/poke_provider.dart';
import 'package:provider/provider.dart';

import '../global/environments.dart';

class PokeServices {

  // static bool loading = false;

  static Future<String?> getPokemons(BuildContext context, String? nextUrl) async {
    final pokePovider = Provider.of<PokePovider>(context, listen: false);
    try {
       Uri uri;
      if(nextUrl == null){
        uri = Uri.parse('${Environment.baseUrl}/pokemon?limit=18');
      } else {
        uri = Uri.parse(nextUrl);
      }
      final response = await http.get(uri,
        headers: {
          'Content-Type': 'application/json'
        }
      );
      final data = pokePaginatedResponseFromJson(response.body);
      List<PokeListItem> listTemp = [];
      listTemp = data.results.map((e) {
        final urlParts = e.url.split('/');
        final id = urlParts[ urlParts.length - 2 ];
        final picture = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
        
        return PokeListItem(name: e.name, picture: picture, id: id);

      }).toList();
      pokePovider.newItems(listTemp);
      // loading = false;
      return data.next;

    } catch(error) {
      if (kDebugMode) {
        print('Error get pokes: $error');
      }
      return null;
    }
  }

  static Future<List<PokeListItem>> getPokemonsSearch(BuildContext context) async {
    final pokePovider = Provider.of<PokePovider>(context, listen: false);

    if(pokePovider.pokemonsFull.isEmpty) {

      try {
        Uri uri = Uri.parse('${Environment.baseUrl}/pokemon?limit=1200');
        final response = await http.get(uri,
          headers: {
            'Content-Type': 'application/json'
          }
        );
        final data = pokePaginatedResponseFromJson(response.body);
        List<PokeListItem> listTemp = [];
        listTemp = data.results.map((e) {
          final urlParts = e.url.split('/');
          final id = urlParts[ urlParts.length - 2 ];
          final picture = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
          
          return PokeListItem(name: e.name, picture: picture, id: id);

        }).toList();

        pokePovider.pokemonsFull = listTemp;
        // loading = false;
        return pokePovider.pokemonsFull;

      } catch(error) {
        if (kDebugMode) {
          print('Error get getPokemonsSearch: $error');
        }
        return [];
      }
    } else {
      return pokePovider.pokemonsFull;
    }
  }

  static Future<Pokemon?> getPokemon(String id) async {
    try {
       Uri uri = Uri.parse('${Environment.baseUrl}/pokemon/$id');
      final response = await http.get(uri,
        headers: {
          'Content-Type': 'application/json'
        }
      );
      final data = pokemonFromJson(response.body);
     
      return data;

    } catch(error) {
      if (kDebugMode) {
        print('Error get pokemon: $error');
      }
      return null;
    }
  }


}