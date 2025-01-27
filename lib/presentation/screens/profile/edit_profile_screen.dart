import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_assignment/presentation/controllers/profile_controller.dart';

class EditProfileForm extends StatelessWidget {
  final ProfileController controller;

  const EditProfileForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF09141A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Back',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Save profile changes
                    Get.back();
                  },
                  child: const Text(
                    'Save & Update',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Form Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add Image Button
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFF162329),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 24),
                            SizedBox(height: 4),
                            Text(
                              'Add Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Form Fields
                    _buildFormField('Display name', controller.profile?.username ?? ''),
                    _buildFormField('Gender', 'Select Gender', isDropdown: true),
                    _buildFormField('Birthday', 'DD MM YYYY'),
                    _buildFormField('Horoscope', ''),
                    _buildFormField('Zodiac', ''),
                    _buildFormField('Height', 'Add height'),
                    _buildFormField('Weight', 'Add weight'),
                    
                    const SizedBox(height: 24),
                    
                    // Interest Section
                    const Text(
                      'Interest',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF162329),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Add in your interest to find a better match',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String value, {bool isDropdown = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF162329),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                if (isDropdown)
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}