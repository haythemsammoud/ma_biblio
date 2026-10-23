import 'package:flutter/material.dart';
import '../Models/livre.dart';

// Q3.1 : StatefulWidget car l'état (cases cochées) change et l'écran doit
// se redessiner via setState. Un StatelessWidget est immuable.
class MaListeScreen extends StatefulWidget {
  final List<Livre> livres;
  final VoidCallback onModifie;
  final VoidCallback onParametres;

  const MaListeScreen({
    super.key,
    required this.livres,
    required this.onModifie,
    required this.onParametres,
  });

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false; // Q3.2

  // Q3.3
  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  // Q3.4
  final Map<String, IconData> _icones = {
    'Roman': Icons.auto_stories,
    'Science': Icons.science,
    'Histoire': Icons.account_balance,
    'Jeunesse': Icons.child_care,
    'Informatique': Icons.computer,
  };

  // Q3.6 : true = tous cochés, false = aucun, null = mélange (tiret)
  bool? get _tous {
    final valeurs = _genres.values;
    if (valeurs.every((v) => v)) return true;
    if (valeurs.every((v) => !v)) return false;
    return null;
  }

  // Q3.7 : livres filtrés
  List<Livre> get _filtres => widget.livres
      .where(
        (l) =>
            _genres[l.genre] == true && (!_nouveautesSeulement || l.nouveaute),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final filtres = _filtres;
    final lus = filtres.where((l) => l.lu).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lus : $lus / ${filtres.length}'), // Q3.8
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: widget.onParametres,
          ),
        ],
      ),
      body: ListView(
        children: [
          // Q3.2 : sans setState la variable change mais l'écran ne se redessine pas
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (v) => setState(() => _nouveautesSeulement = v ?? false),
          ),
          const Divider(),

          // Q3.6 : case "Tous" à 3 états
          CheckboxListTile(
            title: const Text(
              'Tous les genres',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            tristate: true,
            value: _tous,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (_) {
              setState(() {
                final cocher = _tous != true;
                for (final g in _genres.keys) {
                  _genres[g] = cocher;
                }
              });
            },
          ),

          // Q3.3 + Q3.4 + Q3.5
          ..._genres.keys.map((genre) {
            final nb = widget.livres.where((l) => l.genre == genre).length;
            return CheckboxListTile(
              title: Text(genre),
              subtitle: Text('$nb livre${nb > 1 ? 's' : ''}'),
              secondary: Icon(_icones[genre]),
              activeColor: Colors.teal,
              // .leading = case à gauche ; .trailing = à droite ;
              // .platform = selon la plateforme (à droite sur Android)
              controlAffinity: ListTileControlAffinity.leading,
              value: _genres[genre],
              onChanged: (v) => setState(() => _genres[genre] = v ?? false),
            );
          }),
          const Divider(),

          // Q3.7 : liste imbriquée dans un ListView -> shrinkWrap + physics
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtres.length,
            separatorBuilder: (context, i) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final l = filtres[i];
              return CheckboxListTile(
                value: l.lu,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  l.titre,
                  style: TextStyle(
                    decoration: l.lu ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(l.auteur),
                onChanged: (v) {
                  setState(() => l.lu = v ?? false);
                  widget.onModifie(); // sauvegarde (Q7.9)
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
