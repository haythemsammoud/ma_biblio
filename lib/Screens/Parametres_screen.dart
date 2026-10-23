import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(8),

        children: ListTile.divideTiles(
          context: context,
          color: Colors.grey.shade300,

          tiles: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mon profil'),
              subtitle: const Text('Nom, e-mail, mot de passe'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil sélectionné')),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              subtitle: const Text('Gérer les notifications'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications sélectionnées')),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Langue'),
              subtitle: const Text('Français'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),

            const ListTile(
              leading: Icon(Icons.info),
              title: Text('À propos'),
              subtitle: Text('MaBiblio v1.0\nTP Listes et grilles'),
              isThreeLine: true,
            ),
          ],
        ).toList(),
      ),
    );
  }
}
