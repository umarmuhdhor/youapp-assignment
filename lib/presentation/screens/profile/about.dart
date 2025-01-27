import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_assignment/data/models/profile_model.dart';
import 'package:youapp_assignment/presentation/controllers/profile_controller.dart';

class AboutSection extends StatelessWidget {
  final ProfileController controller;
  final RxBool isEditing = false.obs;
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController horoscopeController = TextEditingController();
  final TextEditingController zodiacController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final RxString selectedGender = "".obs;

  AboutSection({Key? key, required this.controller}) : super(key: key) {
    displayNameController.text = controller.profile?.username ?? 'John Doe';
    birthdayController.text = controller.profile?.birthday ?? '28/08/1995';
    horoscopeController.text = controller.profile?.horoscope ?? 'Virgo';
    zodiacController.text = 'Pig';
    heightController.text = (controller.profile?.height ?? 175).toString();
    weightController.text = (controller.profile?.weight ?? 69).toString();
    selectedGender.value = 'Male';
  }

  void _updateProfile() {
    final updatedProfile = Profile(
      username: displayNameController.text,
      birthday: birthdayController.text,
      horoscope: horoscopeController.text,
      height: int.tryParse(heightController.text) ?? 0,
      weight: int.tryParse(weightController.text) ?? 0,
    );

    controller.updateProfile(updatedProfile as Map<String, dynamic>);
    isEditing.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: const Color(0xFF162329),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section remains the same
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isEditing.value)
                      TextButton(
                        onPressed: _updateProfile,
                        child: const Text(
                          'Save & Update',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    if (!isEditing.value)
                      GestureDetector(
                        onTap: () => isEditing.value = true,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                  ],
                ),
                if (!isEditing.value) ...[
                  const SizedBox(height: 16),
                  _buildInfoRow('Birthday:',
                      '${controller.profile?.birthday ?? "28/08/1995"} (Age ${_calculateAge(controller.profile?.birthday ?? "28/08/1995")})'),
                  _buildInfoRow(
                      'Horoscope:', controller.profile?.horoscope ?? 'Virgo'),
                  _buildInfoRow('Zodiac:', 'Pig'),
                  _buildInfoRow(
                      'Height:', '${controller.profile?.height ?? 175} cm'),
                  _buildInfoRow(
                      'Weight:', '${controller.profile?.weight ?? 69} kg'),
                ] else ...[
                  const SizedBox(height: 24),
                  // Profile Image Section - Aligned to left
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF09141A),
                      borderRadius: BorderRadius.circular(40),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/default_profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add image',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildEditRow('Display name:', displayNameController,
                      initialValue: 'John Doe'),
                  _buildDropdownRow(
                      'Gender:', selectedGender, ['Male', 'Female', 'Other']),
                  _buildEditRow('Birthday:', birthdayController,
                      initialValue: '28 08 1995'),
                  _buildEditRow('Horoscope:', horoscopeController,
                      initialValue: 'Virgo'),
                  _buildEditRow('Zodiac:', zodiacController,
                      initialValue: 'Pig'),
                  _buildEditRow('Height:', heightController,
                      initialValue: '175 cm'),
                  _buildEditRow('Weight:', weightController,
                      initialValue: '69 kg'),
                ],
              ],
            ),
          ),
        ));
  }

  Widget _buildEditRow(
    String label,
    TextEditingController controller, {
    String initialValue = '',
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF09141A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  hintText: initialValue,
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(String label, Rx<String> value, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF09141A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: value.value,
                dropdownColor: const Color(0xFF09141A),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                icon:
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                items: items.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    value.value = newValue;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditField(
    String label,
    TextEditingController controller, {
    String initialValue = '',
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF09141A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintText: initialValue,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
      String label, Rx<String> value, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF09141A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<String>(
              value: value.value,
              dropdownColor: const Color(0xFF09141A),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              items: items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  value.value = newValue;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int _calculateAge(String birthdate) {
    try {
      final parts = birthdate.split('/');
      if (parts.length != 3) return 0;

      final birthday = DateTime(
          int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      final today = DateTime.now();
      int age = today.year - birthday.year;
      if (today.month < birthday.month ||
          (today.month == birthday.month && today.day < birthday.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }
}
