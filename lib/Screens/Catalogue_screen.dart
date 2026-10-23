import 'package:flutter/material.dart';
import 'package:ma_biblio/Widgets/Livre_card.dart';
import '../data/Livres_data.dart';
import '../widgets/Livre_card.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nouveautes = livres.where((livre) => livre.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('MaBiblio - Catalogue')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Nouveautés',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nouveautes.length,
              itemBuilder: (context, index) {
                final livre = nouveautes[index];

                return Container(
                  width: 110,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: livre.couleur,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: livres.length,
              separatorBuilder: (context, index) => const Divider(indent: 72),
              itemBuilder: (context, index) {
                return livreTile(livres[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
