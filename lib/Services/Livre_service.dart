import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import '../Models/livre.dart';

// Fichier local modifiable (les assets, eux, sont en lecture seule).
Future<File> _fichierLocal() async {
  final dossier = await getApplicationDocumentsDirectory();
  return File('${dossier.path}/mabiblio.json');
}

// Q7.4 + Q7.8 : async car la lecture de fichier est une opération lente
// (on ne veut pas bloquer l'interface pendant ce temps).
Future<List<Livre>> chargerLivres() async {
  String? contenu;

  final fichier = await _fichierLocal();
  if (await fichier.exists()) {
    contenu = await fichier.readAsString(); // choix de l'utilisateur
  }
  contenu ??= await rootBundle.loadString(
    'assets/livres.json',
  ); // données d'origine

  final List<dynamic> donnees = jsonDecode(contenu);
  return donnees.map((e) => Livre.fromJson(e as Map<String, dynamic>)).toList();
}

// Q7.7
Future<void> sauvegarderLivres(List<Livre> livres) async {
  final fichier = await _fichierLocal();
  final texte = jsonEncode(livres.map((l) => l.toJson()).toList());
  await fichier.writeAsString(texte);
}

// Q7.10 : supprime la sauvegarde -> on retrouvera assets/livres.json
Future<void> reinitialiserLivres() async {
  final fichier = await _fichierLocal();
  if (await fichier.exists()) {
    await fichier.delete();
  }
}
