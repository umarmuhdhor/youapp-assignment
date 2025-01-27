import 'package:get/get.dart';
import 'package:youapp_assignment/data/models/profile_model.dart';
import 'package:youapp_assignment/data/services/api_services.dart';

class ProfileController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final _profile = Rxn<Profile>();
  final _isLoading = false.obs;
  final _errorMessage = RxnString();

  Profile? get profile => _profile.value;
  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = null;
      final response = await _apiService.getProfile();
      print("response : ${response.name}");
      _profile.value = response;
    } catch (e) {
      _errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      print('1');
      _isLoading.value = true;
      _errorMessage.value = null;
      print('1');

      final response = await _apiService.updateProfile(data);
      print('2');
      _profile.value = response;
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      _errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}
