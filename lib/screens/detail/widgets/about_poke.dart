import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/pokemon_response.dart';
import '../../../widgets/divider.dart';
import '../../../widgets/poke_size.dart';

class AboutPoke extends StatelessWidget {
  const AboutPoke({
    super.key,
    required this.pokemon,
  });

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PokeSize(
          iconData: FontAwesomeIcons.weightHanging,
          value: '${(pokemon!.weight / 10)} kg', 
          label: 'Weight'
        ),
        const CustomDivider(height: 50),
        PokeSize(
          iconData: FontAwesomeIcons.rulerVertical, 
          value: '${(pokemon!.height / 10)} m', 
          label: 'Height'
        ),
        const CustomDivider(height: 50),
        Column(
          children: [
            ...pokemon!.abilities.map((e) => Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(e.ability.name, style: const TextStyle(color: Colors.black87),))),
            const SizedBox(height: 12),
            const Text('Abilities', style: TextStyle(fontSize: 12))
          ],
        ),
      ],
    );
  }
}