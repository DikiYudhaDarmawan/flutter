import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom_flutter/app/utils/api.dart';
import '../controllers/dashboard_controller.dart';
import 'ekskul_detail_view.dart';

class IndexView extends GetView<DashboardController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Ekskul Tersedia'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.ekskuls.isEmpty) {
            return const Center(child: Text("Belum ada ekskul tersedia."));
          }

          return ListView.separated(
            itemCount: controller.ekskuls.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final ekskul = controller.ekskuls[index];
              final isRegistered = ekskul.isRegistered ?? false;

              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => Get.to(() => EkskulDetailView(ekskul: ekskul)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Gambar Ekskul
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.network(
                          ekskul.foto ??
                              'https://via.placeholder.com/600x300.png?text=Ekskul',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 180,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text("Gambar tidak tersedia"),
                            ),
                          ),
                        ),
                      ),

                      // Konten
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ekskul.name ?? '-',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              ekskul.description ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 18, color: Colors.redAccent),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    ekskul.location ?? 'Lokasi tidak tersedia',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Get.to(
                                        () => EkskulDetailView(ekskul: ekskul));
                                  },
                                  icon:
                                      const Icon(Icons.info_outline, size: 18),
                                  label: const Text("Lihat Detail"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),

                                // Status Button
                                isRegistered
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 12),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.grey[100],
                                        ),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.check_circle,
                                                color: Colors.grey, size: 18),
                                            SizedBox(width: 6),
                                            Text(
                                              "Sudah Mendaftar",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      )
                                    : OutlinedButton.icon(
                                        onPressed: () async {
                                          final token =
                                              GetStorage().read('token');
                                          await Api.daftarEkskul(
                                              token, ekskul.id!);
                                          Get.snackbar(
                                            "Berhasil",
                                            "Anda mendaftar ke ${ekskul.name}",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                          );
                                        },
                                        icon: const Icon(Icons.add_circle,
                                            color: Colors.green),
                                        label: const Text("Daftar"),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.green,
                                          side: const BorderSide(
                                              color: Colors.green),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
