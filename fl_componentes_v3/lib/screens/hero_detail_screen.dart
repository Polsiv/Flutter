import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/heroes_provider.dart';
import '../models/hero_model.dart';

class HeroDetailScreen extends StatefulWidget {
  final int heroId;

  const HeroDetailScreen({Key? key, required this.heroId}) : super(key: key);

  @override
  State<HeroDetailScreen> createState() => _HeroDetailScreenState();
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  HeroModel? hero;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHero();
  }

  Future<void> _loadHero() async {
    final provider = Provider.of<HeroesProvider>(context, listen: false);
    final data = await provider.heroesService.getHeroById(widget.heroId);
    setState(() {
      hero = data;
      print("hero id:\n ");
      print(widget.heroId);
      print("hero:\n ");
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (hero == null) {
      return const Scaffold(
        body: Center(child: Text('Héroe no encontrado')),
      );
    }

    final bool hasValidImage =
        hero!.img.isNotEmpty && hero!.img.startsWith('http');

    return Scaffold(
      appBar: AppBar(title: Text(hero!.nombre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            hasValidImage
                ? Image.network(
                    hero!.img,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.person,
                            size: 100, color: Colors.grey),
                      );
                    },
                  )
                : Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.person,
                        size: 100, color: Colors.grey),
                  ),
            const SizedBox(height: 16),
            Text(hero!.bio, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Casa: ${hero!.casa}', style: const TextStyle(fontSize: 14)),
            Text('Aparición: ${hero!.aparicion}',
                style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
