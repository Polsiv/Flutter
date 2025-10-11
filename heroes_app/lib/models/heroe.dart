class Heroe {
  final String id;
  final String nombre;
  final String? bio;
  final String? img;
  final DateTime? aparicion;
  final String? casa;

  Heroe({
    required this.id,
    required this.nombre,
    this.bio,
    this.img,
    this.aparicion,
    this.casa,
  });

  factory Heroe.fromJson(Map<String, dynamic> json) {
    DateTime? parsed;
    final a = json['aparicion'];

    if (a is String && a.isNotEmpty) {
      try {
        parsed = DateTime.parse(a);
      } catch (_) {
        parsed = null;
      }
    }

    return Heroe(
      id: json['_id'] as String,
      nombre: json['nombre'] as String,
      bio: json['bio'] as String?,
      img: json['img'] as String?,
      aparicion: parsed,
      casa: json['casa'] as String?,
    );
  }
}
