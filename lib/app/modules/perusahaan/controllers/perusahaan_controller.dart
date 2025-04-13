import 'package:get/get.dart';
import 'package:ujikom_selpi/app/data/perusahaan_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PerusahaanController extends GetxController {
  var isLoading = true.obs;
  var perusahaanList = <Perusahaan>[].obs;

  @override
  void onInit() {
    fetchPerusahaan();
    super.onInit();
  }

  void fetchPerusahaan() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://192.168.100.140:8000/api/perusahaan/'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final perusahaanResponse = PerusahaanResponse.fromJson(jsonData);
        perusahaanList.value = perusahaanResponse.data ?? [];
      } else {
        Get.snackbar('Error', 'Gagal mengambil data perusahaan');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading(false);
    }
  }
}
