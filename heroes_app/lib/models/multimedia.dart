enum MultimediaType { image, video, audio, other }

MultimediaType _typeFrom(String? t) {
  switch (t?.toLowerCase()) {
    case 'image':
      return MultimediaType.image;
    case 'video':
      return MultimediaType.video;
    case 'audio':
      return MultimediaType.audio;
    default:
      return MultimediaType.other;
  }
}

class Multimedia {
  final String id;
  final String? heroeId;
  final String? titulo;
  final String? url;
  final MultimediaType tipo;
  final String? thumbnail;

  Multimedia({
    required this.id,
    this.heroeId,
    this.titulo,
    this.url,
    required this.tipo,
    this.thumbnail,
  });

  factory Multimedia.fromJson(Map<String, dynamic> json) {
    return Multimedia(
      id: json['_id']?.toString() ?? '',
      heroeId: json['heroeId']?.toString() ?? json['heroe']?.toString(),
      titulo: json['titulo']?.toString() ?? json['title']?.toString(),
      url: json['url']?.toString(),
      tipo: _typeFrom(json['tipo']?.toString() ?? json['type']?.toString()),
      thumbnail: json['thumbnail']?.toString() ?? json['thumb']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'heroeId': heroeId,
      'titulo': titulo,
      'url': url,
      'tipo': tipo.name,
      'thumbnail': thumbnail,
    };
  }
}
