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
      appBar: AppBar(
        title: const Text('Ekskul List'),
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
            return const Center(child: Text("Data tidak tersedia"));
          }
          return ListView.builder(
            itemCount: controller.ekskuls.length,
            itemBuilder: (context, index) {
              final ekskul = controller.ekskuls[index];
              final bool sudahMendaftar = ekskul.isRegistered ?? false;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://picsum.photos/id/${ekskul.id}/700/300',
                          fit: BoxFit.cover,
                          height: 180,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Text('Gambar tidak ditemukan'),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ekskul.name ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ekskul.description ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.red),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              ekskul.location ?? 'Lokasi tidak tersedia',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Get.to(() => EkskulDetailView(ekskul: ekskul));
                            },
                            icon: const Icon(Icons.info_outline),
                            label: const Text('Lihat Detail'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          sudahMendaftar
                              ? OutlinedButton.icon(
                                  onPressed: null,
                                  icon: const Icon(Icons.check_circle,
                                      color: Colors.grey),
                                  label: const Text('Anda Telah Mendaftar'),
                                )
                              : OutlinedButton.icon(
                                  onPressed: () async {
                                    // String token = "USER_ACCESS_TOKEN";
                                    String token = GetStorage().read('token');
                                    await Api.daftarEkskul(token, ekskul.id!);
                                    Get.snackbar(
                                      "Pendaftaran Berhasil",
                                      "Anda telah mendaftar ke ekskul ${ekskul.name}",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                    );
                                  },
                                  icon: const Icon(Icons.check_circle,
                                      color: Colors.green),
                                  label: const Text('Daftar Sekarang'),
                                ),
                        ],
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
