import 'package:get/get.dart';
import 'package:youapp_assignment/data/models/auth_model.dart';
import 'package:youapp_assignment/data/services/api_services.dart';
import 'package:youapp_assignment/routes/app_routes.dart';

class AuthController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final _isLoading = false.obs;
  final _errorMessage = RxnString();

  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;

  Future<void> login(String email, String username, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = null;

      final request = LoginRequest(
        email: email,
        username: username,
        password: password,
      );

      final response = await _apiService.login(request);

      if (response.accessToken != null) {
        Get.offAllNamed(Routes.profile);
      } else {
        // Jika gagal, tampilkan pesan error
        final errorBody = response.message;
        _errorMessage.value = errorBody ?? 'Login failed';
      }
    } catch (e) {
      // Tangani error lainnya (misalnya koneksi internet)
      _errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> register(String email, String username, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = null;

      final request = RegisterRequest(
        email: email,
        username: username,
        password: password,
      );

      await _apiService.register(request);
      Get.snackbar(
        'Success',
        'Registration successful. Please login.',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.toNamed(Routes.login);
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
