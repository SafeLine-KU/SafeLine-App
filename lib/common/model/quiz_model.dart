class QuizQuestion {
  final String id;
  final List<String> type;
  final List<String> situation;
  final String imageUrl;

  QuizQuestion({
    required this.id,
    required this.type,
    required this.situation,
    required this.imageUrl,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'],
      type: List<String>.from(json['type']),
      situation: List<String>.from(json['situtation']),
      imageUrl: json['image'],
    );
  }
}
