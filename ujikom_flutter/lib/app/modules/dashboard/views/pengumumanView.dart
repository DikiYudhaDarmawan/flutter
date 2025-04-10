import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/pengumumanController.dart';

class PengumumanView extends StatelessWidget {
  final PengumumanController controller = Get.put(PengumumanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengumuman"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.pengumumanList.isEmpty) {
          return const Center(child: Text("Tidak ada pengumuman"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.pengumumanList.length,
          itemBuilder: (context, index) {
            final item = controller.pengumumanList[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                        image: item.foto != null && item.foto!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(item.foto!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: (item.foto == null || item.foto!.isEmpty)
                          ? Icon(Icons.image, color: Colors.grey[600])
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.judul ?? "Tanpa Judul",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.description ?? "Tidak ada deskripsi",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Diumumkan pada: ${item.createdAt ?? '-'}",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
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
    );
  }
}
