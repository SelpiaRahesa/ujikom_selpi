import 'package:get/get.dart';
import 'package:ujikom_selpi/app/data/perusahaan_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PerusahaanController extends GetxController {
  // Mengubah perusahaanList menjadi future yang akan mengembalikan Future<List<Perusahaan>>.
 Future<PerusahaanResponse> fetchPerusahaan() async {
  try {
    final response = await http.get(Uri.parse('http://10.10.8.163:8000/api/perusahaan/'));
    print('Response: ${response.body}');  // Menampilkan response untuk debug

    if (response.statusCode == 200) {
      return PerusahaanResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load perusahaan');
    }
  } catch (e) {
    print('Error: $e');  // Menangani error
    rethrow;
  }
}

}
