import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../services/heroes_service.dart';
import '../core/http_client.dart';
import '../models/heroe.dart';
import '../providers/multimedia_provider.dart';
import '../widgets/multimedia_gallery.dart';

class HeroeDetailScreen extends StatefulWidget {
  final String heroeId;
  const HeroeDetailScreen({super.key, required this.heroeId});

  @override
  State<HeroeDetailScreen> createState() => _HeroeDetailScreenState();
}

class _HeroeDetailScreenState extends State<HeroeDetailScreen> {
  final _service = HeroesService(HttpClient());
  Heroe? _heroe;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final h = await _service.fetchHeroeById(widget.heroeId);
      setState(() { _heroe = h; });
      // cargar multimedia en paralelo
      // (usa Provider para reutilizar estado si vuelves)
      // ignore: use_build_context_synchronously
      context.read<MultimediaProvider>().loadByHero(widget.heroeId);
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mprov = context.watch<MultimediaProvider>();
    final df = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Héroe')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : _heroe == null
                  ? const Center(child: Text('No encontrado'))
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_heroe!.img != null && _heroe!.img!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  _heroe!.img!,
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 220,
                                      width: double.infinity,
                                      color: Colors.grey.shade300,
                                      child: const Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),

                              ),
                            const SizedBox(height: 12),
                            Text(_heroe!.nombre, style: Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                if (_heroe!.casa != null) Chip(label: Text(_heroe!.casa!)),
                                const SizedBox(width: 8),
                                if (_heroe!.aparicion != null)
                                  Chip(label: Text('Aparición: ${df.format(_heroe!.aparicion!)}')),
                              ],
                            ),
                            const SizedBox(height: 12),
                            if ((_heroe!.bio ?? '').isNotEmpty)
                              Text(_heroe!.bio!),

                            const SizedBox(height: 24),
                            Text('Multimedia', style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 12),
                            if (mprov.loading)
                              const Center(child: CircularProgressIndicator())
                            else if (mprov.error != null)
                              Text('Error cargando multimedia: ${mprov.error}')
                            else
                              MultimediaGallery(items: mprov.items),
                          ],
                        ),
                      ),
                    ),
    );
  }
}