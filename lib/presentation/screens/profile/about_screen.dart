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
  final RxString imageUrl = "".obs;

  AboutSection({Key? key, required this.controller}) : super(key: key) {
    displayNameController.text = controller.profile?.name ?? '';
    birthdayController.text = controller.profile?.birthday ?? '';
    horoscopeController.text = controller.profile?.horoscope ?? '';
    heightController.text = controller.profile?.height != null && controller.profile!.height != 0
        ? controller.profile!.height.toString()
        : '';
    weightController.text = controller.profile?.weight != null && controller.profile!.weight != 0
        ? controller.profile!.weight.toString()
        : '';
    selectedGender.value = controller.profile?.gender ?? '';
    // imageUrl.value = controller.profile?.imageUrl ?? '';
  }

  void _updateProfile() async {
    final updatedProfile = Profile(
      name: displayNameController.text,
      birthday: birthdayController.text,
      horoscope: horoscopeController.text,
      height: int.tryParse(heightController.text) ?? 0,
      weight: int.tryParse(weightController.text) ?? 0,
      gender: selectedGender.value,
      // imageUrl: imageUrl.value,
    );

    try {
      await controller.updateProfile(updatedProfile.toJson());
      isEditing.value = false;
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
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
                  _buildInfoRow('Display name:', controller.profile?.name ?? ''),
                  _buildInfoRow('Gender:', controller.profile?.gender ?? ''),
                  _buildInfoRow('Birthday:', controller.profile?.birthday ?? ''),
                  _buildInfoRow('Horoscope:', controller.profile?.horoscope ?? ''),
                  _buildInfoRow('Height:', controller.profile?.height != null && controller.profile!.height != 0
                      ? '${controller.profile!.height} cm'
                      : ''),
                  _buildInfoRow('Weight:', controller.profile?.weight != null && controller.profile!.weight != 0
                      ? '${controller.profile!.weight} kg'
                      : ''),
                ] else ...[
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () async {
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: imageUrl.value.isNotEmpty
                          ? NetworkImage(imageUrl.value)
                          : AssetImage('assets/images/default_profile.png') as ImageProvider,
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
                      hintText: 'Enter name'),
                  _buildDropdownRow(
                      'Gender:', selectedGender, ['Male', 'Female', 'Other']),
                  _buildEditRow('Birthday:', birthdayController,
                      hintText: 'DD MM YYYY'),
                  _buildEditRow('Horoscope:', horoscopeController,
                      hintText: 'Enter horoscope'),
                  _buildEditRow('Zodiac:', zodiacController,
                      hintText: 'Enter zodiac'),
                  _buildEditRow('Height:', heightController,
                      hintText: 'Add height', keyboardType: TextInputType.number),
                  _buildEditRow('Weight:', weightController,
                      hintText: 'Add weight', keyboardType: TextInputType.number),
                ],
              ],
            ),
          ),
        ));
  }

  Widget _buildEditRow(
    String label,
    TextEditingController controller, {
    String hintText = '',
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
                  hintText: hintText,
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
                value: value.value.isNotEmpty ? value.value : null,
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
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value.isNotEmpty ? value : '-',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}