class ApiConfig {
    static const String base = "https://rest-sorella-production.up.railway.app/api";
    static Uri heroes() => Uri.parse('$base/heroes');
    static Uri heroeById(String id) => Uri.parse('$base/heroes/$id');
    static Uri multimedias() => Uri.parse('$base/multimedias');
    static Uri multimediasByHeroe(String id) => Uri.parse('$base/multimedias/heroe/$id');
}

