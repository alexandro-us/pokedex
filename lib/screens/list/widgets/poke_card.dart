import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/poke_model.dart';
import 'package:pokedex/screens/detail/poke_detail_screen.dart';

class PokeCard extends StatelessWidget {

  const PokeCard({Key? key, required this.poke}) : super(key: key);
  final PokeListItem poke;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PokeDetailScreen(poke: poke, image: NetworkImage(poke.picture)))),
      child: Container(
        // padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              // blurRadius: 4,
              color: Color.fromARGB(40, 0, 0, 0),
              offset: Offset(1, 2),
            )
          ]
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 60,
                // color:  const Color(0xFFEFEFEF),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all((size.width <= 375) ? 6.0 : 8.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text('#${poke.id}'),
                  ),
                  Image.network(poke.picture, width: (size.width <= 375) ? 48 : 54),
                  const SizedBox(height: 5),
                  Text(poke.name, overflow: TextOverflow.ellipsis,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}