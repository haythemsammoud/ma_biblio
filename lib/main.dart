import 'package:flutter/material.dart';

import 'Models/livre.dart';
import 'Screens/catalogue_screen.dart';
import 'Screens/galerie_screen.dart';
import 'Screens/ma_liste_screen.dart';
import 'Screens/Parametres_screen.dart';
import 'Services/Livre_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0; // Q8.1 : onglet actif
  late Future<List<Livre>> _futurLivres; // Q7.5

  @override
  void initState() {
    super.initState();
    _futurLivres = chargerLivres(); // chargé une seule fois
  }

  // Q1.6 : ouverture de l'écran Paramètres
  void _ouvrirParametres() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ParametresScreen(onReinitialiser: _reinitialiser),
      ),
    );
  }

  // Q7.10
  Future<void> _reinitialiser() async {
    await reinitialiserLivres();
    setState(() => _futurLivres = chargerLivres());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Livre>>(
        future: _futurLivres,
        builder: (context, snapshot) {
          // 1) chargement
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2) erreur
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Erreur : ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          // 3) données reçues
          final livres = snapshot.data!;

          // Q7.9 + Q8.3 : sauvegarde + redessin de tous les onglets
          void modifie() {
            sauvegarderLivres(livres);
            setState(() {});
          }

          final ecrans = <Widget>[
            CatalogueScreen(
              livres: livres,
              onModifie: modifie,
              onParametres: _ouvrirParametres,
            ),
            GalerieScreen(
              livres: livres,
              onModifie: modifie,
              onParametres: _ouvrirParametres,
            ),
            MaListeScreen(
              livres: livres,
              onModifie: modifie,
              onParametres: _ouvrirParametres,
            ),
          ];

          return ecrans[_index]; // Q8.2
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Catalogue'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: 'Galerie'),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Ma liste',
          ),
        ],
      ),
    );
  }
}
