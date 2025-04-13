import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ujikom_selpi/app/data/profile_response.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  final token = GetStorage().read('access_token');
  final isLoading = false.obs;
  var user = Rxn<ProfileResponse>();

  @override
  void onInit() {
    // Cek apakah token ada
    if (token == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Error", "Token tidak ditemukan, silakan login.");
      });
      // Jangan langsung logout ke halaman login, beri kesempatan pengguna
      // untuk login terlebih dahulu, ini jika user belum login.
    } else {
      getProfile(); // Lanjutkan mengambil data profil
    }
    super.onInit();
  }

  void getProfile() async {
    try {
      isLoading(true);

      // Cek ulang token saat mengambil profil
      final token = GetStorage().read('access_token');
      if (token == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar("Error", "Token tidak ditemukan, silakan login ulang.");
        });
        return;
      }

      final response = await http.get(
        Uri.parse('http://192.168.100.140:8000/api/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is Map<String, dynamic>) {
          final profileResponse = ProfileResponse.fromJson(jsonData);
          user.value = profileResponse;
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.snackbar("Error", "Format data tidak valid (bukan JSON)");
          });
        }
      } else if (response.statusCode == 401) {
        // Token kadaluarsa atau tidak valid
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar("Unauthorized", "Sesi login habis, silakan login ulang.");
        });
        Get.offAllNamed('/login'); // Arahkan ke login jika sesi habis
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar("Error", "Gagal mengambil data profil (${response.statusCode})");
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Error", "Terjadi kesalahan: $e");
      });
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      final box = GetStorage();
      box.remove('access_token'); // Hapus token
      print("Berhasil logout!");
      Get.offAllNamed('/login'); // Redirect ke login setelah logout
    } catch (e) {
      print("Error saat logout: $e");
    }
  }
}
