import 'package:flutter/material.dart';
import '../models/hero_model.dart';

class HeroCard extends StatelessWidget {
  final HeroModel hero;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HeroCard({
    Key? key,
    required this.hero,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasValidImage = hero.img.isNotEmpty && hero.img.startsWith('http');

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade300,
          child: hasValidImage
              ? ClipOval(
                  child: Image.network(
                    hero.img,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, color: Colors.grey, size: 30);
                    },
                  ),
                )
              : const Icon(Icons.person, color: Colors.grey, size: 30),
        ),
        title: Text(hero.nombre),
        subtitle: Text(hero.casa.isNotEmpty ? hero.casa : 'Sin casa'),
        onTap: onTap,
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
