import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ujikom_selpi/app/modules/perusahaan/controllers/perusahaan_controller.dart';

class PerusahaanView extends StatelessWidget {
  final PerusahaanController controller = Get.put(PerusahaanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      appBar: AppBar(
        title: const Text('Daftar Perusahaan'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          // Menampilkan animasi handshake Lottie saat loading
          return Center(
            child: Lottie.asset(
              'assets/handshake.json', // Pastikan path benar
              width: 200,
              height: 200,
            ),
          );
        }

        if (controller.perusahaanList.isEmpty) {
          return const Center(child: Text('Tidak ada perusahaan.'));
        }

        String baseUrl = 'http://192.168.100.140:8000/storage/perusahaans/';
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.perusahaanList.length,
            itemBuilder: (context, index) {
              final perusahaan = controller.perusahaanList[index];

            String imageUrl = (perusahaan.image ?? '').contains('http')
    ? perusahaan.image!
    : 'http://192.168.100.140:8000/storage/${perusahaan.image}';
// Gambar placeholder jika tidak ada image

              return Card(
                elevation: 8, // 3D effect
                shadowColor: Colors.black.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Avatar image bulat
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          imageUrl,  // Menggunakan URL lengkap yang telah dibuat
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 60),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Nama perusahaan
                      Expanded(
                        child: Text(
                          perusahaan.namaPerusahaan ?? '-',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            physics: BouncingScrollPhysics(), // Efek scrolling lebih smooth
          ),
        );
      }),
    );
  }
}
