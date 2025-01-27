import 'package:get/get.dart';
import 'package:youapp_assignment/presentation/bindings/auth_binding.dart';
import 'package:youapp_assignment/presentation/bindings/profile_binding.dart';
import 'package:youapp_assignment/presentation/screens/auth/login_screen.dart';
import 'package:youapp_assignment/presentation/screens/auth/register_screen.dart';
import 'package:youapp_assignment/presentation/screens/profile/edit_profile_screen.dart';
import 'package:youapp_assignment/presentation/screens/profile/profile_screen.dart';
import 'package:youapp_assignment/routes/app_routes.dart';


class AppPages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}