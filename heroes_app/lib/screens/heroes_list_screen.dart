import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/heroes_provider.dart';
import '../widgets/heroe_card.dart';
import '../router/app_router.dart';

class HeroesListScreen extends StatefulWidget {
  const HeroesListScreen({super.key});

  @override
  State<HeroesListScreen> createState() => _HeroesListScreenState();
}

class _HeroesListScreenState extends State<HeroesListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HeroesProvider>().loadHeroes());
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<HeroesProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Héroes')),
      body: Builder(
        builder: (_) {
          if (prov.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (prov.error != null) {
            return Center(child: Text('Error: ${prov.error}'));
          }
          if (prov.heroes.isEmpty) {
            return const Center(child: Text('Sin héroes.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: prov.heroes.length,
            itemBuilder: (_, i) {
              final h = prov.heroes[i];
              return HeroeCard(
                heroe: h,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.heroeDetail,
                  arguments: {'id': h.id},
                )
              );
            }
          );
        },
      ),
    );
  }
}
