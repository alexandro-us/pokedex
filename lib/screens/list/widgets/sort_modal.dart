import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pokedex/providers/poke_provider.dart';
import 'package:provider/provider.dart';

import '../../../../theme/app_theme.dart';
class SortModal extends StatefulWidget {

  // final EventModel event;
  const SortModal(
      {Key? key,})
      : super(key: key);


  @override
  _SortModalState createState() => _SortModalState();
}

class _SortModalState extends State<SortModal> {

  @override
  void initState() {
    super.initState();
    getInitData();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  String? sortSelected;

  getInitData() {
    final pokeProvider = Provider.of<PokePovider>(context, listen: false);
    sortSelected = pokeProvider.sortType;
  }

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 6,
        ),
        child: Container(
          width: 300,
          decoration: const BoxDecoration(
            color: Color(0xB3FFFFFF),
          ),
          alignment: const AlignmentDirectional(0, 0),
          child: Container(
            width: 300,
            constraints: const BoxConstraints(
              maxWidth: 300,
            ),
            decoration: BoxDecoration(
              color: AppTheme.lightPrimaryColor,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: SelectionArea(
                              child: Text(
                            'Sort By:',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 16, 0),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.white
                      ),
                      child: Column(
                        children:[
                          itemSortSelected('Number'),
                          itemSortSelected('Name'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemSortSelected(String item) {
    final pokeProvider = Provider.of<PokePovider>(context, listen: false);
    return SizedBox(
      // width: 120,
      child: RadioListTile(
        // contentPadding: EdgeInsets.z,
        title: Text(item, style: const TextStyle(fontSize: 18, color: Colors.black87),),
        value: item, 
        selectedTileColor: AppTheme.lightPrimaryColor,
        activeColor: AppTheme.lightPrimaryColor,
        groupValue: sortSelected, 
        onChanged: (value){
          setState(() {
              sortSelected = value.toString();
          });
          pokeProvider.sortType = sortSelected!;
          pokeProvider.sort();
          Navigator.pop(context);
        },
      ),
    );
  }

}
