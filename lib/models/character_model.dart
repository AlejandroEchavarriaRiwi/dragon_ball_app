class Character {
  final int id;
  final String name;
  final String ki;
  final String maxKi;
  final String race;
  final String gender;
  final String description;
  final String imageUrl;
  final String affiliation;

  Character({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.imageUrl,
    required this.affiliation,
  });

  // Método para crear una instancia desde un JSON
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      ki: json['ki'],
      maxKi: json['maxKi'],
      race: json['race'],
      gender: json['gender'],
      description: json['description'],
      imageUrl: json['image'],
      affiliation: json['affiliation'],
    );
  }
}
