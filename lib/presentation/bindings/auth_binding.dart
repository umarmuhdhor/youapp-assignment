import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:youapp_assignment/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}