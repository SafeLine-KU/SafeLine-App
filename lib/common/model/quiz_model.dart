class Quiz {
  final String id;
  final List<String> type;
  final List<String> situation;
  final String imageUrl;

  Quiz({
    required this.id,
    required this.type,
    required this.situation,
    required this.imageUrl,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      type: List<String>.from(json['type']),
      situation: List<String>.from(json['situtation']),
      imageUrl: json['image'],
    );
  }
}
