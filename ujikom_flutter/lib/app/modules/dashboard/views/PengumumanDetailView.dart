import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_flutter/app/data/pengumumanResponse.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PengumumanDetailView extends StatelessWidget {
  const PengumumanDetailView({super.key, required this.pengumuman});
  final PengumumanData pengumuman;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Pengumuman",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: HexColor("#5F6368"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image or Placeholder
              if (pengumuman.foto != null && pengumuman.foto!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    pengumuman.foto!,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: HexColor("#F1F3F4"),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.image,
                    size: 60,
                    color: HexColor("#B0BEC5"),
                  ),
                ),
              const SizedBox(height: 20),
              // Title
              Text(
                pengumuman.judul ?? 'Tanpa Judul',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: HexColor("#212121"),
                ),
              ),
              const SizedBox(height: 10),
              // Date
              Text(
                "Diumumkan pada: ${pengumuman.createdAt ?? '-'}",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#607D8B"),
                ),
              ),
              const Divider(height: 30),
              // Description
              Text(
                pengumuman.description ?? 'Tidak ada deskripsi',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#424242"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
