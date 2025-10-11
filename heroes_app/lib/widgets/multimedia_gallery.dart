import 'package:flutter/material.dart';
import '../models/multimedia.dart';

class MultimediaGallery extends StatelessWidget {
  final List<Multimedia> items;

  const MultimediaGallery({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No hay multimedia disponible.'));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, i) {
        final m = items[i];
        final thumb = m.thumbnail ?? m.url ?? '';
        final label = m.titulo ?? m.tipo.name.toUpperCase();

        return Tooltip(
          message: label,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (thumb.isNotEmpty)
                Image.network(thumb, fit: BoxFit.cover)
              else
                Container(color: Colors.grey.shade300),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
