import 'package:flutter/material.dart';
import '../models/heroe.dart';

class HeroeCard extends StatelessWidget {
  final Heroe heroe;
  final VoidCallback onTap;

  const HeroeCard({super.key, required this.heroe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            if (heroe.img != null && heroe.img!.isNotEmpty)
              Image.network(
                heroe.img!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // fallback if URL fails
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              )
            else
              // fallback if img is null/empty
              Container(
                width: 100,
                height: 100,
                color: Colors.grey.shade300,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: ListTile(
                title: Text(
                  heroe.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(heroe.casa ?? 'sin casa'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
