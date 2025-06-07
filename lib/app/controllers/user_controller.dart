import 'package:get/get.dart';
import '../data/models/user_model.dart';
import '../data/services/api_service.dart';

class UserController extends GetxController {
  final ApiService _apiService = ApiService();
  
  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }
  
  Future<void> fetchUserInfo() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    
    try {
      final userData = await _apiService.getUserInfo();
      user.value = userData;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      
      user.value = User(
        id: 1000, 
        nickname: '김미림',
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<bool> fetchPaymentHistory() async {
    isLoading.value = true;
    hasError.value = false;
    
    try {
      await _apiService.getPaymentHistory();
      return true;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<bool> fetchCardInfo() async {
    isLoading.value = true;
    hasError.value = false;
    
    try {
      await _apiService.getCardInfo();
      return true;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<bool> registerFacePayment(String base64Image) async {
    isLoading.value = true;
    hasError.value = false;
    
    try {
      final result = await _apiService.registerFacePayment(base64Image);
      return result;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}