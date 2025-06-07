enum AlertType {
  inStock,
  soldOut,
}

class AlertModel {
  final int id;
  final AlertType type;
  final String message;
  final String date;

  AlertModel({
    required this.id,
    required this.type,
    required this.message,
    required this.date,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id'] ?? 0,
      type: AlertType.values[json['type'] ?? 0],
      message: json['message'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'message': message,
      'date': date,
    };
  }

  String get typeDisplayText {
    return type == AlertType.inStock ? '입고' : '품절';
  }

  String get formattedDate {
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.month}월 ${dateTime.day}일';
    } catch (e) {
      return date;
    }
  }
}