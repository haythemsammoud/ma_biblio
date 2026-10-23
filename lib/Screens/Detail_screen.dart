import 'package:flutter/material.dart';
import '../Models/livre.dart';

// Q4.8 : StatefulWidget, car l'icône change quand on bascule le favori.
class DetailScreen extends StatefulWidget {
  final Livre livre;
  final VoidCallback onModifie;

  const DetailScreen({super.key, required this.livre, required this.onModifie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final livre = widget.livre;

    return Scaffold(
      appBar: AppBar(title: Text(livre.titre)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: livre.couleur,
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Auteur'),
                  subtitle: Text(livre.auteur),
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Année'),
                  subtitle: Text('${livre.annee}'),
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Genre'),
                  subtitle: Text(livre.genre),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: OverflowBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: Icon(
                          livre.favori ? Icons.favorite : Icons.favorite_border,
                        ),
                        label: Text(
                          livre.favori
                              ? 'Retirer des favoris'
                              : 'Ajouter aux favoris',
                        ),
                        onPressed: () {
                          setState(() => livre.favori = !livre.favori);
                          widget.onModifie();
                        },
                      ),
                      TextButton.icon(
                        icon: Icon(
                          livre.lu
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                        ),
                        label: Text(
                          livre.lu ? 'Marqué comme lu' : 'Marquer comme lu',
                        ),
                        onPressed: () {
                          setState(() => livre.lu = !livre.lu);
                          widget.onModifie();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
