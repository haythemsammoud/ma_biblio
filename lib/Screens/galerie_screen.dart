import 'package:flutter/material.dart';
import '../Models/livre.dart';
import '../Widgets/Livre_card.dart';
import '../Widgets/Livre_grid_item.dart';
import 'Detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  final List<Livre> livres;
  final VoidCallback onModifie;
  final VoidCallback onParametres;

  const GalerieScreen({
    super.key,
    required this.livres,
    required this.onModifie,
    required this.onParametres,
  });

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  bool _modeGrille = true; // Q6.6
  bool _triParNote = false; // Q6.7

  // Q6.4 : responsive
  int _colonnes(double largeur) {
    if (largeur < 600) return 2;
    if (largeur <= 900) return 3;
    return 4;
  }

  void _ouvrirDetail(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            DetailScreen(livre: livre, onModifie: widget.onModifie), // Q6.5
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Copie triée (on ne modifie pas l'ordre du catalogue)
    final liste = [...widget.livres];
    if (_triParNote) {
      liste.sort((a, b) => b.note.compareTo(a.note));
    }

    final largeur = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie'),
        actions: [
          IconButton(
            tooltip: 'Trier par note',
            icon: Icon(
              Icons.sort,
              color: _triParNote ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () => setState(() => _triParNote = !_triParNote),
          ),
          IconButton(
            tooltip: _modeGrille ? 'Afficher en liste' : 'Afficher en grille',
            icon: Icon(_modeGrille ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _modeGrille = !_modeGrille),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: widget.onParametres,
          ),
        ],
      ),
      body: _modeGrille
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: liste.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _colonnes(largeur),
                childAspectRatio: 0.7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              // Q6.3 : équivalent de GridView.extent
              // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              //   maxCrossAxisExtent: 180,
              //   childAspectRatio: 0.7,
              //   mainAxisSpacing: 12,
              //   crossAxisSpacing: 12,
              // ),
              itemBuilder: (context, i) => LivreGridItem(
                livre: liste[i],
                onTap: () => _ouvrirDetail(liste[i]),
              ),
            )
          : ListView.builder(
              itemCount: liste.length,
              itemBuilder: (context, i) => LivreCard(
                livre: liste[i],
                onTap: () => _ouvrirDetail(liste[i]),
              ),
            ),
    );
  }
}
