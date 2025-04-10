import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_flutter/app/data/EkskulResponse.dart';

class EkskulDetailView extends GetView {
  const EkskulDetailView({super.key, required this.ekskul});
  final Ekskuls ekskul;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ekskul.name ?? "Detail Ekskul"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Ekskul
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                ekskul.foto?.isNotEmpty == true
                    ? ekskul.foto!
                    : 'https://picsum.photos/id/${ekskul.id}/700/300',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 220,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 220,
                    color: Colors.grey[300],
                    child: const Center(child: Text('Gambar tidak tersedia')),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Nama Ekskul
            Text(
              ekskul.name ?? "Tidak ada nama",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Deskripsi Ekskul
            Text(
              ekskul.description ?? "Tidak ada deskripsi",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Informasi Tambahan dalam Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Lokasi Ekskul
                    ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.red),
                      title: const Text("Lokasi"),
                      subtitle: Text(
                        ekskul.location ?? "Tidak ada lokasi",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const Divider(),

                    // Jadwal Ekskul 1
                    ListTile(
                      leading:
                          const Icon(Icons.event, color: Colors.blueAccent),
                      title: const Text("Jadwal 1"),
                      subtitle: Text(
                        "${ekskul.activityDate ?? 'Tidak tersedia'} | ${ekskul.startTime ?? '--:--'} - ${ekskul.endTime ?? '--:--'}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const Divider(),

                    // Jadwal Ekskul 2 (jika ada)
                    if (ekskul.activityDate2 != null &&
                        ekskul.activityDate2!.isNotEmpty) ...[
                      ListTile(
                        leading:
                            const Icon(Icons.event, color: Colors.blueAccent),
                        title: const Text("Jadwal 2"),
                        subtitle: Text(
                          "${ekskul.activityDate2 ?? 'Tidak tersedia'} | ${ekskul.startTime2 ?? '--:--'} - ${ekskul.endTime2 ?? '--:--'}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const Divider(),
                    ],

                    // Pembina ID (Opsional)
                    if (ekskul.pembinaId != null)
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.green),
                        title: const Text("Pembina ID"),
                        subtitle: Text(ekskul.pembinaId.toString()),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tanggal Dibuat & Diperbarui
            Text(
              "Dibuat: ${ekskul.createdAt ?? '-'}",
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              "Diperbarui: ${ekskul.updatedAt ?? '-'}",
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
