import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/poke_model.dart';
import 'package:pokedex/providers/poke_provider.dart';
import 'package:pokedex/screens/list/widgets/btn_sort_list.dart';
import 'package:pokedex/screens/list/widgets/poke_card.dart';
import 'package:pokedex/services/poke_services.dart';
import 'package:pokedex/theme/app_theme.dart';
import 'package:pokedex/widgets/custom_search_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController queryController;

  @override
  void initState() {
    queryController = TextEditingController(text: '');
    getPokeList();
    super.initState();
  }

  String? nextUrl;
  bool isLoading = false;
  bool loadingNews = false;
  bool isSearch = false;
  List<PokeListItem> resultSearch = [];
  ScrollController scrollController = ScrollController();

  getPokeList() async {
    setState(() {isLoading = true;});
    final resp = await PokeServices.getPokemons(context, null);
    if(resp != null) {
      nextUrl = resp;
    }
    setState(() {isLoading = false;});
  }
  

  loadMoreData() async {
    if(nextUrl != null) {
      setState(() {loadingNews = true;});
      final resp = await PokeServices.getPokemons(context, nextUrl);
      setState(() {
        nextUrl = resp;
        loadingNews = false;
      });
    }
  }

  Future<void> fnSearch(String value) async {
    if(value.length <= 2) return;
    setState(() {
      isSearch = true;
      isLoading = true;
    });
    final fullList = await PokeServices.getPokemonsSearch(context);
    final resp = fullList.where((element) => element.name.contains(value)).toList();
    setState(() {
      resultSearch = resp;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final pokePovider = Provider.of<PokePovider>(context);
    final size = MediaQuery.of(context).size;
    scrollController.addListener((){      
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 ){
        if(loadingNews == false){
          loadMoreData();
        }
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.lightPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                  
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Builder(
                      builder: (context) {
                        if(isLoading){
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          List<PokeListItem> pokes = (isSearch) ? resultSearch : pokePovider.pokemons;
                          if(pokes.isNotEmpty) {
                            return FadeInDown(
                              child: GridView.builder(
                                controller: scrollController,
                                itemCount: pokes.length,
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8
                                  // mainAxisExtent: 80
                                ), 
                                itemBuilder: (context, index) => PokeCard(poke: pokes[index]),
                              ),
                            );
                          } else {
                            return Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Colors.white38
                              ),
                              child: const Text('No hay resultados')
                            );
                          }
                        }
                      }
                    ),
                  ),
                  if(loadingNews)
                    Positioned(
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * 1.0,
                        height: 40,
                        color: Colors.white.withOpacity(0.5),
                        child: const CircularProgressIndicator()
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customAppBar() {
    return GestureDetector(
      onTap: (){
         FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/pokeball.png', width: 50,),
                    const Text('Pokédex', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomSearchBox(
                          controller: queryController, 
                          actionSearch: (val) => fnSearch(val),
                          placeholder: 'Buscar',
                          backgroundColor: Colors.white,
                          actionClear: (){
                            setState(() {
                              queryController.text = '';
                              isSearch = false;
                            });
                          },
                        ),
                      ),
                      const BtnSortList()
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}