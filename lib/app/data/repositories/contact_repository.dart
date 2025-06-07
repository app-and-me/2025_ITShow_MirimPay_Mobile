import 'package:mirim_pay/pages/main/models/question_model.dart';

abstract class ContactRepository {
  Future<List<QuestionModel>> getQuestions();
  Future<void> submitQuestion(String category, String content);
}

class ContactRepositoryImpl implements ContactRepository {
  @override
  Future<List<QuestionModel>> getQuestions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // TODO: API 요청
    final mockData = [
      {
        'question': '초코소라빵 재고 입고됐나요?',
        'date': '2025.04.21',
        'category': '재고',
        'answer': '네~ 어제 20개 정도 입고됐습니다'
      },
      {
        'question': '크림빵 품절인가요?',
        'date': '2025.04.21',
        'category': '품절',
        'answer': '오후 2시까지 20개 재고 있습니다'
      },
      {
        'question': '바게트 추가 재고 확인 가능한가요?',
        'date': '2025.04.21',
        'category': '재고',
        'answer': '현재 10개 남아있습니다'
      },
      {
        'question': '최애빵 입고 언제 되나요?',
        'date': '2025.04.14',
        'category': '입고',
        'answer': '내일 오전 10시 입고 예정입니다'
      },
      {
        'question': '영업 시간이 어떻게 되나요?',
        'date': '2025.04.16',
        'category': '운영',
        'answer': '평일은 오전 9시부터 오후 9시까지, 주말은 오전 10시부터 오후 8시까지 운영합니다'
      },
      {
        'question': '빵 맛이 너무 좋아요!',
        'date': '2025.04.15',
        'category': '그 외',
        'answer': '감사합니다. 더 맛있는 빵으로 보답하겠습니다'
      },
    ];
    
    return mockData.map((json) => QuestionModel.fromJson(json)).toList();
  }

  @override
  Future<void> submitQuestion(String category, String content) async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }
}
