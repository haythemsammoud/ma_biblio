import 'package:flutter/material.dart';
import '../Models/livre.dart';
import 'Livre_tile.dart';

class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback? onTap;

  const LivreCard({super.key, required this.livre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // essayez 0, 4 puis 12 (Q4.2)
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black54,
      // Q4.3 : 'color' remplace la couleur de fond ;
      // 'surfaceTintColor' ajoute une teinte (Material 3) sur la couleur de base.
      // color: Colors.white,
      // surfaceTintColor: Colors.indigo,
      // Q4.5 : sans antiAlias, l'effet d'encre déborde des coins arrondis.
      clipBehavior: Clip.antiAlias,
      child: livreTile(livre, onTap: onTap),
    );
  }
}
