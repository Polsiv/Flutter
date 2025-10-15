import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/heroes_provider.dart';
import '../screens/hero_edit_screen.dart';
import '../widgets/hero_card.dart';

class HeroesListScreen extends StatefulWidget {
  const HeroesListScreen({Key? key}) : super(key: key);

  @override
  State<HeroesListScreen> createState() => _HeroesListScreenState();
}

class _HeroesListScreenState extends State<HeroesListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HeroesProvider>(context, listen: false).loadHeroes();
  }

  @override
  Widget build(BuildContext context) {
    final heroesProvider = Provider.of<HeroesProvider>(context);
    final heroes = heroesProvider.heroes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Héroes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => heroesProvider.loadHeroes(),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HeroEditScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: heroes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: heroes.length,
              itemBuilder: (context, index) {
                final hero = heroes[index];
                return HeroCard(
                  hero: hero,
                  onTap: () => Navigator.pushNamed(
                    context,
                    'heroes_detalle',
                    arguments: hero.id,
                  ),
                  onEdit: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HeroEditScreen(hero: hero),
                    ),
                  ),
                  onDelete: () async {
                    final result = await heroesProvider.deleteHero(hero.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result ?? 'Héroe eliminado'),
                        backgroundColor: result == null ? null : Colors.red,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
