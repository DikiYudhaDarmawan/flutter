import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_flutter/app/modules/dashboard/controllers/EvaluasiController.dart';
import 'package:google_fonts/google_fonts.dart';

class EvaluasiView extends StatelessWidget {
  final EvaluasiController controller = Get.put(EvaluasiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Evaluasi Ekskul',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.evaluasiList.isEmpty) {
            return Center(
              child: Text(
                "Belum ada evaluasi",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return ListView.separated(
            itemCount: controller.evaluasiList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              var evaluasi = controller.evaluasiList[index];

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul Ekskul
                      Text(
                        evaluasi.ekskul?.name ?? 'Ekskul tidak diketahui',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Grade dan Deskripsi
                      _buildInfoItem("Grade", evaluasi.grade ?? 'N/A'),
                      const Divider(),
                      _buildInfoItem("Deskripsi",
                          evaluasi.description ?? 'Tidak ada keterangan'),

                      const SizedBox(height: 12),

                      // Tanggal Dibuat
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "🕒 Dibuat: ${evaluasi.createdAt ?? '-'}",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
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

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
