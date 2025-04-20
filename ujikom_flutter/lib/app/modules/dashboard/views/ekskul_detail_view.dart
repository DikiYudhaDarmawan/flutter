import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_flutter/app/data/EkskulResponse.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class EkskulDetailView extends GetView {
  const EkskulDetailView({super.key, required this.ekskul});
  final Ekskuls ekskul;

  @override
  Widget build(BuildContext context) {
    final primaryColor = HexColor("#6200EE");
    final darkText = HexColor("#212121");
    final lightText = HexColor("#757575");
    final greyLine = HexColor("#E0E0E0");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ekskul.name ?? "Detail Ekskul",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Ekskul
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                ekskul.foto?.isNotEmpty == true
                    ? ekskul.foto!
                    : 'https://picsum.photos/id/${ekskul.id}/700/300',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 220,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text('Gambar tidak tersedia'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nama Ekskul
            Text(
              ekskul.name ?? "Tidak ada nama",
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
            const SizedBox(height: 8),

            // Deskripsi Ekskul
            Text(
              ekskul.description ?? "Tidak ada deskripsi",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: lightText,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),

            // Informasi Tambahan
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 4,
              shadowColor: Colors.black12,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    _buildInfoTile(
                      icon: Icons.location_on,
                      iconColor: Colors.red,
                      title: 'Lokasi',
                      subtitle: ekskul.location ?? "Tidak ada lokasi",
                    ),
                    Divider(color: greyLine),
                    _buildInfoTile(
                      icon: Icons.event,
                      iconColor: Colors.blueAccent,
                      title: 'Jadwal 1',
                      subtitle:
                          "${ekskul.activityDate ?? '-'} | ${ekskul.startTime ?? '--:--'} - ${ekskul.endTime ?? '--:--'}",
                    ),
                    if (ekskul.activityDate2 != null &&
                        ekskul.activityDate2!.isNotEmpty) ...[
                      Divider(color: greyLine),
                      _buildInfoTile(
                        icon: Icons.event,
                        iconColor: Colors.blueAccent,
                        title: 'Jadwal 2',
                        subtitle:
                            "${ekskul.activityDate2 ?? '-'} | ${ekskul.startTime2 ?? '--:--'} - ${ekskul.endTime2 ?? '--:--'}",
                      ),
                    ],
                    if (ekskul.pembinaId != null) ...[
                      Divider(color: greyLine),
                      _buildInfoTile(
                        icon: Icons.person,
                        iconColor: Colors.green,
                        title: 'Pembina ID',
                        subtitle: ekskul.pembinaId.toString(),
                      ),
                    ]
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

           
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: GoogleFonts.poppins(fontSize: 14, color: HexColor("#616161")),
        ),
      ),
    );
  }
}
