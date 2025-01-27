import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    
    final _nameController = TextEditingController(text: controller.profile?.name);
    final _heightController = TextEditingController(
        text: controller.profile?.height?.toString());
    final _weightController = TextEditingController(
        text: controller.profile?.weight?.toString());
        
    final _selectedGender = (controller.profile?.gender ?? '').obs;
    final _selectedDate = (controller.profile?.birthday ?? '').obs;
    final _interests = (controller.profile?.interests ?? []).obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          Obx(() {
            if (controller.isLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }
            return TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  controller.updateProfile({
                    'name': _nameController.text,
                    'gender': _selectedGender.value,
                    'birthday': _selectedDate.value,
                    'height': int.tryParse(_heightController.text),
                    'weight': int.tryParse(_weightController.text),
                    'interests': _interests,
                  });
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Gender'),
              Row(
                children: [
                  Obx(() => Radio<String>(
                        value: 'male',
                        groupValue: _selectedGender.value,
                        onChanged: (value) => _selectedGender.value = value!,
                      )),
                  const Text('Male'),
                  Obx(() => Radio<String>(
                        value: 'female',
                        groupValue: _selectedGender.value,
                        onChanged: (value) => _selectedGender.value = value!,
                      )),
                  const Text('Female'),
                ],
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    _selectedDate.value =
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Birthday',
                    border: OutlineInputBorder(),
                  ),
                  child: Obx(() => Text(
                        _selectedDate.value.isEmpty
                            ? 'Select date'
                            : _selectedDate.value,
                      )),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          final height = int.tryParse(value);
                          if (height == null || height < 0) {
                            return 'Invalid height';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          final weight = int.tryParse(value);
                          if (weight == null || weight < 0) {
                            return 'Invalid weight';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Interests'),
              Wrap(
                spacing: 8,
                children: [
                  'Reading',
                  'Writing',
                  'Gaming',
                  'Cooking',
                  'Travel',
                  'Music',
                  'Sports',
                  'Art',
                ].map((interest) {
                  return Obx(() {
                    final isSelected = _interests.contains(interest);
                    return FilterChip(
                      label: Text(interest),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          _interests.add(interest);
                        } else {
                          _interests.remove(interest);
                        }
                      },
                    );
                  });
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}