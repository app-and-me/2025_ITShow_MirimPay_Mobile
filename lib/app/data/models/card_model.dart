class Card {
  final int id;
  final String name;
  final String number;
  bool isMainCard;
  final String? imageUrl;

  Card({
    required this.id,
    required this.name,
    required this.number,
    this.imageUrl,
    this.isMainCard = false,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      imageUrl: json['image_url'],
      isMainCard: json['is_main_card'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'image_url': imageUrl,
      'is_main_card': isMainCard,
    };
  }
}
