class Player {
  final String id;
  final String name;
  String? assignedWord;
  bool isImposter;
  int score;

  Player({
    required this.id,
    required this.name,
    this.assignedWord,
    this.isImposter = false,
    this.score = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      score: json['score'] ?? 0,
    );
  }
}