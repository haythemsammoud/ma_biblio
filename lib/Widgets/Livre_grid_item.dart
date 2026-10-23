import 'package:flutter/material.dart';
import '../Models/livre.dart';

class LivreGridItem extends StatelessWidget {
  final Livre livre;
  final VoidCallback? onTap;

  const LivreGridItem({super.key, required this.livre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: livre.couleur,
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.menu_book, color: Colors.white, size: 40),
                    const SizedBox(height: 8),
                    Text(
                      livre.titre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      livre.auteur,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (livre.favori)
              const Positioned(
                top: 6,
                right: 6,
                child: Icon(Icons.favorite, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
