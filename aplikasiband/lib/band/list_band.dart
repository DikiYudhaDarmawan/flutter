import 'package:flutter/material.dart';

import 'detail_band.dart';

class ListBand extends StatelessWidget {
  final List<Map<String, dynamic>> detail_band = [
    {
      "nama": "BabyMetal",
      "image":
          "https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1634025439/01h0y9rx90vqveecns5hb2parr.jpg",
      "gallery": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW2uwiG9YB35MJuaxQUPl0tVai_S9QsveY8Q&s",
        "https://www.rukita.co/stories/wp-content/uploads/2023/03/Babymetal.jpg",
        "https://cdns.klimg.com/resized/1200x600/p/headline/konser-di-indonesia-babymetal-sukses-me-b5b188.jpg",
      ],
      "desc":
          "Babymetal adalah grup vokal dan tari beraliran exprimental metal asal Jepang yang awalnya terbentuk pada tahun 2010 sebagai sub-unit dari grup idola Sakura Gakuin. Band ini terdiri dari 3 gadis sekolah: SU-METAL, MOAMETAL dan MOMOMETAL",
    },
    {
      "nama": "queen",
      "image":
          "https://imgsrv2.voi.id/mib3qD17KqRV64r_eY_-QkD-SuZO9I2JxbZb0XS2ZYg/auto/1280/853/sm/1/bG9jYWw6Ly8vcHVibGlzaGVycy8zNTI4Ny8yMDIxMDIyNDE0MDktbWFpbi5jcm9wcGVkXzE2MTQxNTA1NTIuanBn.jpg",
      "gallery": [
        "https://cdn1-production-images-kly.akamaized.net/5RNNRK9_JgJmlCWrKr0hqrQDoK0=/1200x1200/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/1070491/original/033742400_1448849563-queen-bohemian-rhapsody-covers.jpg",
        "https://qph.cf2.quoracdn.net/main-qimg-33fce33b98181be0b3663718f590adf4-lq",
      ],
      "desc":
      "Queen adalah grup musik rock dari Britania Raya yang dibentuk tahun 1970 di London. Semula, mereka terdiri dari Freddie Mercury, Brian May, Roger Meddows- Taylor, dan John Deaco" 
         },
    {
      "nama": "Bring Me The Horizon",
      "image":
          "https://asset.kompas.com/crops/fvybaEkERVjKGAzdQLwfcysNVvI=/0x0:1080x720/750x500/data/photo/2023/08/25/64e82da9e956d.png",
      "gallery": [
        "https://awsimages.detik.net.id/community/media/visual/2023/11/11/bring-me-the-horizon_43.jpeg?w=600&q=90",
        "https://static.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/p1/04/2024/01/05/5alagu-1895499172.jpg",
      ],
      "desc":
      "Bring Me the Horizon adalah grup musik rock Inggris yang dibentuk di Sheffield pada tahun 2004. Saat ini grup ini digawangi vokalis Oliver Sykes, gitaris Lee Malia, bassis Matt Kean, dan drummer Matt Nicholls."
    },

    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            itemCount: detail_band.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBand(
                        nama: detail_band[index]["nama"],
                        image: detail_band[index]["image"],
                        gallery: detail_band[index]["gallery"],
                        desc: detail_band[index]["desc"],
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 200,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage("${detail_band[index]["image"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Text(
                      "${detail_band[index]["nama"]}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
