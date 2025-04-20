import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/ProfileSiswaController.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/dashboard_controller.dart';

class ProfileSiswaView extends StatelessWidget {
  const ProfileSiswaView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileSiswaController());
    final profileSiswaController = Get.find<ProfileSiswaController>();
    final dashboardController = Get.find<DashboardController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Profil Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await dashboardController.logOut();
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Obx(() {
        if (profileSiswaController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (profileSiswaController.profile.value == null) {
          return const Center(child: Text("Data profil tidak tersedia"));
        }

        final data = profileSiswaController.profile.value!;
        final fotoUrl = data.user?.foto;
        final avatarImage = (fotoUrl != null && fotoUrl.isNotEmpty)
            ? NetworkImage(fotoUrl)
            : null;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header dengan avatar dan info dasar
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: avatarImage,
                      child: avatarImage == null
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.blueAccent)
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      data.user?.name ?? "Nama tidak tersedia",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.user?.email ?? "",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Informasi detail siswa
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.school,
                              color: Colors.blueAccent),
                          title: const Text("Kelas"),
                          subtitle: Text(
                            data.kelas?.tingkat != null
                                ? "Kelas ${data.kelas!.tingkat}"
                                : "Tidak tersedia",
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.category,
                              color: Colors.blueAccent),
                          title: const Text("Jurusan"),
                          subtitle: Text(
                            data.jurusan?.nama ?? "Tidak tersedia",
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading:
                              const Icon(Icons.timer, color: Colors.blueAccent),
                          title: const Text("Gelombang Belajar"),
                          subtitle: Text(
                            data.gelombangBelajar?.gelombang != null
                                ? "Gelombang ${data.gelombangBelajar!.gelombang}"
                                : "Tidak tersedia",
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading:
                              const Icon(Icons.phone, color: Colors.blueAccent),
                          title: const Text("No. Telepon"),
                          subtitle: Text(
                            data.nomorTelp?.isNotEmpty == true
                                ? data.nomorTelp!
                                : "Tidak tersedia",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tombol Edit Profil
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton.icon(
                  onPressed: profileSiswaController.goToEditProfile,
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profil"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }
}
