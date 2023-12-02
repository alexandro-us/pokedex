import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/widgets/custom_title.dart';

import '../../../models/pokemon_response.dart';

class SpritesPoke extends StatelessWidget {
  const SpritesPoke({
    super.key,
    required this.pokemon, this.primary,
  });

  final Pokemon? pokemon;
  final Color? primary;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomTitle(title: 'Sprites', primary: primary),
        FadeInDown(
          duration: const Duration(milliseconds: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(pokemon!.sprites.frontDefault, width: size.width * 0.2),
              Image.network(pokemon!.sprites.backDefault, width: size.width * 0.2),
              Image.network(pokemon!.sprites.frontShiny, width: size.width * 0.2),
              Image.network(pokemon!.sprites.backShiny, width: size.width * 0.2)
            ]
          ),
        ),
      ],
    );
  }
}