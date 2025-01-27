import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_assignment/presentation/controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }

          final profile = controller.profile;
          print(profile?.username);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Get.back(),
                        ),
                        const Text('Back',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Text(
                      '@${profile?.username ?? ""}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Username
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  '@${profile?.username ?? ""}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),

              // About Section
              Padding(
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
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: Colors.grey, size: 20),
                          onPressed: () {
                            // Handle edit about
                          },
                        ),
                      ],
                    ),
                    const Text(
                      'Add in your your to help others know you better',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    if (profile != null) ...[
                      const SizedBox(height: 16),
                      if (profile.name?.isNotEmpty ?? false)
                        Text(
                          'Name: ${profile.name}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      if (profile.birthday?.isNotEmpty ?? false)
                        Text(
                          'Birthday: ${profile.birthday}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      if (profile.horoscope != 'Error')
                        Text(
                          'Horoscope: ${profile.horoscope}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      if (profile.height != 0)
                        Text(
                          'Height: ${profile.height} cm',
                          style: const TextStyle(color: Colors.white),
                        ),
                      if (profile.weight != 0)
                        Text(
                          'Weight: ${profile.weight} kg',
                          style: const TextStyle(color: Colors.white),
                        ),
                    ],
                  ],
                ),
              ),

              // Interests Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Interest',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: Colors.grey, size: 20),
                          onPressed: () {
                            // Handle edit interests
                          },
                        ),
                      ],
                    ),
                    const Text(
                      'Add in your interest to find a better match',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    if (profile?.interests?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: profile!.interests!
                            .map((interest) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    interest,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
