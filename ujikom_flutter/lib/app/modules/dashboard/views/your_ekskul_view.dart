import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/YourEkskulController.dart';

class YourEkskulView extends GetView<YourEkskulController> {
  const YourEkskulView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(YourEkskulController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ekskul Saya'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.ekskuls.isEmpty) {
            return const Center(child: Text("Anda belum mengikuti ekskul"));
          }
          return ListView.builder(
            itemCount: controller.ekskuls.length,
            itemBuilder: (context, index) {
              final ekskul = controller.ekskuls[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Icon(Icons.sports, color: Colors.blue),
                  title: Text(ekskul.ekskul?.name ?? 'Tidak diketahui'),
                  subtitle:
                      Text(ekskul.ekskul?.description ?? 'Tanpa Deskripsi'),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          value: "pengumuman", child: Text("Lihat Pengumuman")),
                      PopupMenuItem(value: "nilai", child: Text("Lihat Nilai")),
                    ],
                    onSelected: (value) {
                      if (value == "pengumuman") {
                        controller.goToPengumuman(ekskul.ekskul?.id);
                      } else if (value == "nilai") {
                        controller.goToNilai(ekskul.ekskul?.id);
                      }
                    },
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
