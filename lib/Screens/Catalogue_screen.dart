import 'package:flutter/material.dart';
import '../Models/livre.dart';
import '../Widgets/Livre_card.dart';
import 'Detail_screen.dart';

class CatalogueScreen extends StatelessWidget {
  final List<Livre> livres;
  final VoidCallback onModifie;
  final VoidCallback onParametres;

  const CatalogueScreen({
    super.key,
    required this.livres,
    required this.onModifie,
    required this.onParametres,
  });

  void _ouvrirDetail(BuildContext context, Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(livre: livre, onModifie: onModifie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nouveautes = livres.where((l) => l.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: onParametres),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Text(
              'Nouveautés',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Q2.7 : ListView horizontal dans un SizedBox (hauteur imposée)
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nouveautes.length,
              itemBuilder: (context, i) {
                final l = nouveautes[i];
                return GestureDetector(
                  onTap: () => _ouvrirDetail(context, l),
                  child: Container(
                    width: 110,
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: l.couleur,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      l.titre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 16, 12, 8),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Q2.8 : sans Expanded -> erreur "Vertical viewport was given
          // unbounded height". Q2.5 : ListView.builder ne construit que les
          // éléments visibles (lazy), contrairement à ListView(children: ...)
          // qui crée les 1000 widgets d'un coup.
          // Q4.4 : les cartes ont leurs marges -> plus besoin de .separated
          Expanded(
            child: ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, i) => LivreCard(
                livre: livres[i],
                onTap: () => _ouvrirDetail(context, livres[i]), // Q4.7
              ),
            ),
          ),
        ],
      ),
    );
  }
}
