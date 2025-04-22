import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ujikom_selpi/app/data/perusahaan_response.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../controllers/perusahaan_controller.dart';

class PerusahaanView extends GetView {
  const PerusahaanView({super.key});

  @override
  Widget build(BuildContext context) {
    final PerusahaanController controller = Get.put(PerusahaanController());
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Perusahaan'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<PerusahaanResponse>(
          future: controller.fetchPerusahaan(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                  'assets/lottie/handshake.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Terjadi kesalahan: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
              return const Center(child: Text('Tidak ada perusahaan.'));
            }

            List<Perusahaan> perusahaanList = snapshot.data!.data!;

            return ListView.builder(
              itemCount: perusahaanList.length,
              controller: scrollController,
              itemBuilder: (context, index) {
                final perusahaan = perusahaanList[index];
                return ZoomTapAnimation(
                  onTap: () {
                    // TODO: Arahkan ke detail perusahaan jika ada
                  },
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Logo
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'http://192.168.100.140:8000/storage/perusahaans/${perusahaan.image}',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.image_not_supported),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Info
                          Expanded(
                            child: Text(
                              perusahaan.namaPerusahaan ?? 'Nama Perusahaan',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
