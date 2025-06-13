import 'package:mirim_pay/util/service/auth_service.dart';

class AppRoutes {
  static const String main = '/';
  static const String paymentHistory = '/payment-history';
  static const String cardInfo = '/card-info';
  static const String faceRegistration = '/face-registration';
  static const String alert = '/alert';
  static const String login = '/login';
  static const String contactUs = '/contact-us';
  static const String contactUsWrite = '/contact_us_write';
  static const String pinSetup = '/pin-setup';
  static const String pinConfirm = '/pin-confirm';
  static const String product = '/product';
  static const String pay = '/pay';
  static const String cardWrite = '/card_write';
  static const String faceCamera = '/face-camera';
  static const String me = '/me';
  static const String faceRegistrationSuccess = '/face-registration-success';
  static const String passwordResetCurrent = '/password-reset-current';
  static const String passwordResetNew = '/password-reset-new';
  static const String passwordResetConfirm = '/password-reset-confirm';
}

class AppConstants {
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 8.0;
  static const double dividerThickness = 2.0;
  static Future<Map<String, String>> getHeaders() async {
    String token = await auth.getAccessToken();
    print(token);
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}

class AppStrings {
  static const String myInfo = '내 정보';
  static const String paymentHistory = '결제 내역';
  static const String cardInfo = '카드 정보';
  static const String faceRegistration = '얼굴 결제 등록';
  static const String passwordReset = '결제 비밀번호 재설정';
  static const String logout = '로그아웃';
  static const String error = '오류';
  static const String logoutError = '로그아웃 중 오류가 발생했습니다.';
  static const String userDataError = '사용자 정보를 불러오는데 실패했습니다.';
  static const String defaultName = '이름';
  static const String loginFailed = 'Login Failed';
  static const String tryAgain = 'Please try again.';
  static const String loginWithMirim = '미림 계정으로 로그인';
  static const String loginDescription1 = '손 안에서 매점 결제부터 재고 확인까지';
  static const String loginDescription2 = '전과는 다른, 새로운 매점을 지금 만나보세요';
}
