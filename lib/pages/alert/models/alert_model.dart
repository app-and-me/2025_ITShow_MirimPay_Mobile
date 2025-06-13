enum AlertType {
  inStock,
  soldOut,
}

class AlertModel {
  final int id;
  final AlertType type;
  final String message;
  final String date;
  final bool isRead;

  AlertModel({
    required this.id,
    required this.type,
    required this.message,
    required this.date,
    this.isRead = false,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    int alertId = json['id'] ?? 0;
    int typeIndex = 0;
    
    if (json['type'] is String) {
      typeIndex = int.tryParse(json['type']) ?? 0;
    } else if (json['type'] is int) {
      typeIndex = json['type'];
    }
    
    return AlertModel(
      id: alertId,
      type: AlertType.values[typeIndex],
      message: json['message'] ?? '',
      date: json['date'] ?? '',
      isRead: json['isread'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'message': message,
      'date': date,
      'isRead': isRead,
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