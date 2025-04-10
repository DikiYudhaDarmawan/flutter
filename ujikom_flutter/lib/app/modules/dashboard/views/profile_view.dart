import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/profileController.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    final DashboardController dashboardController =
        Get.find<DashboardController>(); // Panggil DashboardController

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Anda'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (profileController.profile.value == null) {
          return const Center(
            child: Text(
              "Gagal memuat profil",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        final profile = profileController.profile.value!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Avatar Profile
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    profile.name[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  profile.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profile.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),

                // Profile Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildProfileRow(Icons.person, "Nama", profile.name),
                        _buildProfileRow(Icons.email, "Email", profile.email),
                        _buildProfileRow(Icons.badge, "Role", profile.role),
                        _buildProfileRow(
                          Icons.check_circle,
                          "Status",
                          profile.status == 1 ? "Aktif" : "Nonaktif",
                          statusColor:
                              profile.status == 1 ? Colors.green : Colors.red,
                        ),
                        _buildProfileRow(
                            Icons.date_range, "Dibuat pada", profile.createdAt),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),

      // FloatingActionButton untuk Logout
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dashboardController.logOut(); // Panggil logOut dari controller
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.logout, color: Colors.white),
      ),
    );
  }

  // Widget untuk menampilkan setiap baris informasi
  Widget _buildProfileRow(IconData icon, String label, String value,
      {Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: statusColor ?? Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
