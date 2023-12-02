import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/poke_provider.dart';
import 'sort_modal.dart';

class BtnSortList extends StatelessWidget {
  const BtnSortList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokePovider = Provider.of<PokePovider>(context);

    return InkWell(
      onTap: () => openSortModal(context),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle
        ),
        child: Icon(
          (pokePovider.sortType == 'Name') ? Icons.sort_by_alpha : Icons.format_list_numbered_outlined, 
          color: Colors.grey)
      ),
    );
  }

  openSortModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const SizedBox(
            height: double.infinity,
            child: SortModal(
            ),
          ),
        );
      },
    );
  }
}