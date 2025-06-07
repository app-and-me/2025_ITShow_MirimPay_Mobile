class QuestionModel {
  final String question;
  final String date;
  final String category;
  final String? answer;

  QuestionModel({
    required this.question,
    required this.date,
    required this.category,
    this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'] ?? '',
      date: json['date'] ?? '',
      category: json['category'] ?? '',
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'date': date,
      'category': category,
      'answer': answer,
    };
  }
}
