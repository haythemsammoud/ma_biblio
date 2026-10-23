import 'package:flutter/material.dart';
import 'package:ma_biblio/Models/Livre.dart';
import 'package:ma_biblio/data/Livres_data.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  // Q3.2 : afficher uniquement les nouveautés
  bool _nouveautesSeulement = false;

  // Q3.3 : les cinq genres sont cochés au départ
  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Informatique': true,
    'Jeunesse': true,
  };

  @override
  Widget build(BuildContext context) {
    // Q3.8 : calcul des livres affichés après filtrage
    final livresAffiches = livres.where((livre) {
      final genreSelectionne = _genres[livre.genre] ?? false;
      final nouveauteAcceptee = !_nouveautesSeulement || livre.nouveaute;

      return genreSelectionne && nouveauteAcceptee;
    }).toList();

    final nombreLus = livresAffiches.where((livre) => livre.lu).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lus : $nombreLus / ${livresAffiches.length}'),
      ),
      body: Column(
        children: [
          // Q3.2 : case pour filtrer les nouveautés
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            onChanged: (bool? valeur) {
              setState(() {
                _nouveautesSeulement = valeur ?? false;
              });
            },
          ),

          const Divider(),

          // Q3.3 : générer les cases des cinq genres
          ..._genres.keys.map((genre) {
            return CheckboxListTile(
              title: Text(genre),
              value: _genres[genre],
              activeColor: Colors.indigo,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? valeur) {
                setState(() {
                  _genres[genre] = valeur ?? false;
                });
              },
            );
          }),

          const Divider(),

          // Liste des livres filtrés
          Expanded(
            child: ListView.separated(
              itemCount: livresAffiches.length,
              separatorBuilder: (context, index) => const Divider(indent: 16),
              itemBuilder: (context, index) {
                final livre = livresAffiches[index];

                return CheckboxListTile(
                  value: livre.lu,
                  controlAffinity: ListTileControlAffinity.leading,
                  secondary: CircleAvatar(
                    backgroundColor: livre.couleur,
                    child: const Icon(Icons.book, color: Colors.white),
                  ),
                  title: Text(
                    livre.titre,
                    style: TextStyle(
                      decoration: livre.lu
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(livre.auteur),
                  onChanged: (bool? valeur) {
                    setState(() {
                      livre.lu = valeur ?? false;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
