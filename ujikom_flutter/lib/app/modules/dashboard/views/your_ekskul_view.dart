import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/YourEkskulController.dart';
import 'package:google_fonts/google_fonts.dart';

class YourEkskulView extends GetView<YourEkskulController> {
  const YourEkskulView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(YourEkskulController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ekskul Saya',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.ekskuls.isEmpty) {
            return Center(
              child: Text(
                "Anda belum mengikuti ekskul",
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.ekskuls.length,
            itemBuilder: (context, index) {
              final ekskul = controller.ekskuls[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      // Icon atau Avatar
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blue[100],
                        child: const Icon(Icons.sports, color: Colors.blue),
                      ),
                      const SizedBox(width: 16),

                      // Nama & Deskripsi
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ekskul.ekskul?.name ?? 'Tidak diketahui',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ekskul.ekskul?.description ?? 'Tanpa Deskripsi',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Tombol aksi
                      PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: "pengumuman",
                            child: Text("Lihat Pengumuman"),
                          ),
                          const PopupMenuItem(
                            value: "nilai",
                            child: Text("Lihat Nilai"),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == "pengumuman") {
                            controller.goToPengumuman(ekskul.ekskul?.id);
                          } else if (value == "nilai") {
                            controller.goToNilai(ekskul.ekskul?.id);
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
