class QuestionModel {
  final int id;
  final String title;
  final String? response;
  final String status;
  final String category;
  final String createdAt;

  QuestionModel({
    required this.id,
    required this.title,
    this.response,
    required this.status,
    required this.category,
    required this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      response: json['response'],
      status: json['status'] ?? '',
      category: json['category'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'response': response,
      'status': status,
      'category': category,
      'createdAt': createdAt,
    };
  }
}
