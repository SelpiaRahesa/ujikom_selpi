import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_selpi/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi ProfileController
    Get.put(ProfileController()); // Pastikan controller sudah diinisialisasi

    return Scaffold(
      backgroundColor: Colors.white, // 👈 Tambahkan ini
      appBar: AppBar(title: const Text('Profil')),
      body: Obx(() {
        // Loading state
        if (Get.find<ProfileController>().isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = Get.find<ProfileController>().user.value;

        if (user == null) {
          return const Center(child: Text("Data profil tidak tersedia."));
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Text(
                    user.name?.isNotEmpty ?? false
                        ? user.name![0].toUpperCase()
                        : '',
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name ?? 'Nama tidak tersedia',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email ?? 'Email tidak tersedia',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.find<ProfileController>().logout();
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
