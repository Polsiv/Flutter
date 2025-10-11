import 'package:fl_componentes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fl_componentes/data/data.dart'; // adjust path

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final characters = Datos.datos['results'] as List;

    return Scaffold(
      appBar: AppBar(title: const Text('Card Widget')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final char = characters[index];
          return Column(
            children: [
              CustomCardType2(
                imageUrl: char['image'],
                name: char['name'],
                description: char['status'], 
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
