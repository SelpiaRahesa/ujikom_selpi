import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:ujikom_selpi/app/data/motivation_response.dart';
import 'package:ujikom_selpi/app/modules/dashboard/views/motivation_detail_view.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/motivation_controller.dart';

class MotivationView extends StatelessWidget {
  MotivationView({super.key});

  final MotivationController controller = Get.put(MotivationController());

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.white, // 👈 background putih
      appBar: AppBar(
        title: const Text('Carier Tips'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<MotivationResponse>(
          future: controller.getMotivation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100), // Menjadikan bulat
                  child: Lottie.asset(
                    'assets/lottie/handshake.json',
                    repeat: true,
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.motivation!.isEmpty) {
              return const Center(child: Text("Tidak ada data motivasi"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.motivation!.length,
              controller: scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final Motivation = snapshot.data!.motivation![index];
                return ZoomTapAnimation(
                  onTap: () {
                    Get.to(() => MotivationDetailView(motivation: Motivation));
                  },
                  child: Card(
                    elevation: 8, // 👈 lebih tinggi buat 3D feel
                    shadowColor:
                        Colors.black.withOpacity(0.2), // 👈 lebih tajam
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: Image.network(
                            'http://127.0.0.1:8000/storage/motivasis/${Motivation.image}',
                            fit: BoxFit.cover,
                            height: 180,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                height: 180,
                                child: Center(child: Text('Image not found')),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            Motivation.judul ?? 'Judul tidak tersedia',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
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
