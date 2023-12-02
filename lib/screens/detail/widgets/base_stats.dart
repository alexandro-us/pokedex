import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_response.dart';
import 'package:pokedex/widgets/custom_title.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/divider.dart';
import '../../../widgets/linear_process_indicator.dart';

class BaseStats extends StatelessWidget {
  const BaseStats({Key? key, required this.pokemon, this.primary}) : super(key: key);

  final Pokemon pokemon;
  final Color? primary;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        CustomTitle(
          title: 'Base Stats',
          primary: primary,
        ),
        const SizedBox(height: 16,),
        ListView.builder(
          shrinkWrap: true,
          itemCount: pokemon.stats.length,
          itemBuilder: (context, index) => Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(pokemon.stats[index].stat.name, style: TextStyle(fontWeight: FontWeight.bold, color:primary), overflow: TextOverflow.ellipsis,),
                    const Spacer(),
                    const CustomDivider(height: 20),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 24,
                      child: Text('${pokemon.stats[index].baseStat}', style: const TextStyle(color: Colors.black87))),
                    const SizedBox(width: 4)
                  ],
                )
              ),
              LinearProcessIndicator(
                color: primary ?? AppTheme.lightPrimaryColor, 
                sizeWidth: (size.width <= 375) ? (size.width * 0.45) : (size.width * 0.5), 
                percent: pokemon.stats[index].baseStat
              )
            ],
          ),
        )
      ],
    );
  }
}