import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_assignment/routes/app_pages.dart';
import 'package:youapp_assignment/routes/app_routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'YouApp Test',
      theme: ThemeData.dark(), // Sesuai design Figma yang dark theme
      initialRoute: Routes.login,
      getPages: AppPages.pages,
    )
  );
}
