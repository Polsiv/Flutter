class HeroModel {
  final int? id;
  final String nombre;
  final String bio;
  final String img;
  final String aparicion;
  final String casa;

  HeroModel({
    required this.id,
    required this.nombre,
    required this.bio,
    required this.img,
    required this.aparicion,
    required this.casa,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) => HeroModel(
        id: json['id'] ?? 0,
        nombre: json['nombre'] ?? '',
        bio: json['bio'] ?? '',
        img: json['img'] ?? '',
        aparicion: json['aparicion'] ?? '',
        casa: json['casa'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'bio': bio,
        'img': img,
        'aparicion': aparicion,
        'casa': casa,
      };
}
