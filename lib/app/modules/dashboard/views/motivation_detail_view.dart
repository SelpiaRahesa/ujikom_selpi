import 'package:flutter/material.dart';
import 'package:ujikom_selpi/app/data/motivation_response.dart';

class MotivationDetailView extends StatelessWidget {
  final Motivation motivation;

  const MotivationDetailView({super.key, required this.motivation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 👈 ini dia
      appBar: AppBar(
        title: Text(motivation.judul ?? 'Detail Motivasi'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Motivasi
            motivation.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                            'http://192.168.100.140:8000/storage/motivasis/${motivation.image}',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 250,
                          child: Center(child: Text('Image not found')),
                        );
                      },
                    ),
                  )
                : const SizedBox(),

            const SizedBox(height: 16),

            // Judul Motivasi
            Text(
              motivation.judul ?? 'Judul tidak tersedia',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Deskripsi Motivasi
            Text(
              motivation.deskripsi ?? 'Deskripsi tidak tersedia',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
