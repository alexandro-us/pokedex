import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/models/poke_model.dart';
import 'package:pokedex/models/pokemon_response.dart';
import 'package:pokedex/screens/detail/widgets/about_poke.dart';
import 'package:pokedex/screens/detail/widgets/badge_type_poke.dart';
import 'package:pokedex/screens/detail/widgets/base_stats.dart';
import 'package:pokedex/screens/detail/widgets/sprites_poke.dart';
import 'package:pokedex/services/poke_services.dart';
import 'package:pokedex/widgets/custom_title.dart';

class PokeDetailScreen extends StatefulWidget {
  const PokeDetailScreen({Key? key, required this.poke, required this.image}) : super(key: key);

  final PokeListItem poke;
  final ImageProvider image;

  @override
  State<PokeDetailScreen> createState() => _PokeDetailScreenState();
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {
  PaletteGenerator? paletteGenerator;

  Future<void> _updatePaletteGenerator() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      widget.image,
      size: const Size(72, 72),
      region: Offset.zero & const Size(72, 72),
      maximumColorCount: 20,
    );
    setState(() {});
  }

  @override
  void initState() {
    _updatePaletteGenerator();
    getPokeDetail();
    super.initState();
  }

  Pokemon? pokemon;
  bool isLoading = false;

  Future<void> getPokeDetail() async {
    setState(() {
      isLoading = true;
    });
    final resp = await PokeServices.getPokemon(widget.poke.id);
    if(resp != null) {
      pokemon = resp;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paletteGenerator?.dominantColor?.color ?? Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                CustomAppBar(poke: widget),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                    
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: isLoading 
                        ? const Center(child: CircularProgressIndicator(),)
                        : SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 150,),
                              BadgeTypePoke(paletteGenerator: paletteGenerator, pokemon: pokemon!),
                              const SizedBox(height: 24),
                              CustomTitle(
                                title: 'About', 
                                primary: paletteGenerator?.dominantColor?.color
                              ),
                              const SizedBox(height: 24),
                              AboutPoke(pokemon: pokemon),
                              SpritesPoke(
                                pokemon: pokemon, 
                                primary:  paletteGenerator?.dominantColor?.color
                              ),
                              const SizedBox(height: 24),
                              BaseStats(
                                pokemon: pokemon!,
                                primary: paletteGenerator?.dominantColor?.color,
                              )
                            ],
                          ),
                        )
                    ),
                ),
              ],
            ),
            Positioned(
              top: 50,
              child: SlideInLeft(
                child: Image.network(widget.poke.picture, width: 300,)),
            )
          ],
        ),
      )
    );
    
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.poke,
  });

  final PokeDetailScreen poke;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: Image.asset('assets/images/pokeballlg.png', width: 200)),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context), 
                        icon: const Icon(Icons.arrow_back)),
                      Text(poke.poke.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white))
                    ],
                  ),
                  Text('#${poke.poke.id}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white))
                ],
              ),
              // Image.network(widget.poke.picture, width: 200,)
            ],
          ),
        ),
      ],
    );
  }
}