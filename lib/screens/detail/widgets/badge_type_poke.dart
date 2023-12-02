import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/models/pokemon_response.dart';

import '../../../theme/app_theme.dart';

class BadgeTypePoke extends StatelessWidget {
  const BadgeTypePoke({
    super.key,
    required this.paletteGenerator, required this.pokemon,
  });

  final PaletteGenerator? paletteGenerator;
  final  Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        ...pokemon.types.map((e) => BadgeType(
          paletteGenerator: 
          paletteGenerator, type: e)
        )
      ],
    );
  }
}

class BadgeType extends StatelessWidget {
  const BadgeType({
    super.key,
    required this.paletteGenerator, required this.type,
  });

  final PaletteGenerator? paletteGenerator;
  final Type type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        color: paletteGenerator?.dominantColor?.color ?? AppTheme.lightPrimaryColor,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Text(type.type.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),));
  }
}