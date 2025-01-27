import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_assignment/routes/app_routes.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Get.toNamed(Routes.editProfile),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile;
        if (profile == null) {
          return const Center(child: Text('No profile data'));
        }
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (profile.image != null)
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profile.image!),
                  ),
                ),
              const SizedBox(height: 20),
              _buildInfoTile('Name', profile.name),
              _buildInfoTile('Gender', profile.gender),
              _buildInfoTile('Birthday', profile.birthday),
              _buildInfoTile('Horoscope', profile.horoscope),
              _buildInfoTile('Zodiac', profile.zodiac),
              _buildInfoTile('Height', profile.height?.toString()),
              _buildInfoTile('Weight', profile.weight?.toString()),
              if (profile.interests?.isNotEmpty ?? false) ...[
                const SizedBox(height: 16),
                const Text(
                  'Interests',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  children: profile.interests!
                      .map((interest) => Chip(label: Text(interest)))
                      .toList(),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoTile(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}