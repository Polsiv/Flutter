import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hero_model.dart';
import '../providers/heroes_provider.dart';

class HeroEditScreen extends StatefulWidget {
  final HeroModel? hero;

  const HeroEditScreen({Key? key, this.hero}) : super(key: key);

  @override
  State<HeroEditScreen> createState() => _HeroEditScreenState();
}

class _HeroEditScreenState extends State<HeroEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nombreCtrl;
  late TextEditingController bioCtrl;
  late TextEditingController imgCtrl;
  late TextEditingController aparicionCtrl;
  late TextEditingController casaCtrl;

  @override
  void initState() {
    super.initState();
    final h = widget.hero;
    nombreCtrl = TextEditingController(text: h?.nombre ?? '');
    bioCtrl = TextEditingController(text: h?.bio ?? '');
    imgCtrl = TextEditingController(text: h?.img ?? '');
    aparicionCtrl = TextEditingController(text: h?.aparicion ?? '');
    casaCtrl = TextEditingController(text: h?.casa ?? '');
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    bioCtrl.dispose();
    imgCtrl.dispose();
    aparicionCtrl.dispose();
    casaCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveHero() async {
  if (!_formKey.currentState!.validate()) return;

  final hero = HeroModel(
    id: widget.hero?.id,
    nombre: nombreCtrl.text,
    bio: bioCtrl.text,
    img: imgCtrl.text,
    aparicion: aparicionCtrl.text,
    casa: casaCtrl.text,
  );

  final provider = Provider.of<HeroesProvider>(context, listen: false);

  try {
    final response = widget.hero == null
        ? await provider.addHero(hero)
        : await provider.updateHero(hero);

    if (response['ok'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.hero == null
              ? 'Héroe creado correctamente'
              : 'Héroe actualizado correctamente'),
        ),
      );
      Navigator.pop(context);
      await provider.loadHeroes();
    } else {
      final msg = response['msg'] ?? 'Error desconocido';


      if (msg.contains('Hable con el Administrador') &&
          response['err']?['parent']?['code'] == 'ER_TRUNCATED_WRONG_VALUE') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fecha inválida.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠️ $msg')),
        );
      }
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('❌ Error al guardar: ${e.toString()}')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final isEdit = widget.hero != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar héroe' : 'Nuevo héroe')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: bioCtrl,
                decoration: const InputDecoration(labelText: 'Biografía'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: imgCtrl,
                decoration: const InputDecoration(labelText: 'URL Imagen'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: aparicionCtrl,
                decoration: const InputDecoration(
                    labelText: 'Aparición (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La fecha es obligatoria';
                  }

                  final RegExp fechaRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                  if (!fechaRegex.hasMatch(value)) {
                    return 'Formato inválido. Usa YYYY-MM-DD';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: casaCtrl,
                decoration:
                    const InputDecoration(labelText: 'Casa (Marvel/DC)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _saveHero,
                icon: const Icon(Icons.save),
                label: Text(isEdit ? 'Guardar cambios' : 'Crear héroe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
