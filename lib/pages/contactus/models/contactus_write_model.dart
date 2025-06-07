class ContactUsWriteModel {
  final String id;
  final String category;
  final String content;
  final DateTime createdAt;
  final ContactUsStatus status;

  ContactUsWriteModel({
    required this.id,
    required this.category,
    required this.content,
    required this.createdAt,
    this.status = ContactUsStatus.pending,
  });

  factory ContactUsWriteModel.fromJson(Map<String, dynamic> json) {
    return ContactUsWriteModel(
      id: json['id'] ?? '',
      category: json['category'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      status: ContactUsStatus.values[json['status'] ?? 0],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'status': status.index,
    };
  }
}

enum ContactUsStatus {
  pending,
  processing,
  completed,
}
