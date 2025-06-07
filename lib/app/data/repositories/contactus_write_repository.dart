import 'package:mirim_pay/pages/contactus/models/contactus_write_model.dart';

abstract class ContactUsWriteRepository {
  Future<bool> submitContactUs(ContactUsWriteModel contactUs);
  List<String> getCategories();
}

class ContactUsWriteRepositoryImpl implements ContactUsWriteRepository {
  @override
  Future<bool> submitContactUs(ContactUsWriteModel contactUs) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // TODO: API 요청
    return true;
  }

  @override
  List<String> getCategories() {
    return ['재고', '입고', '품절', '운영', '그 외'];
  }
}
