import 'package:get/get.dart';
import 'package:ujikom_selpi/app/data/motivation_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MotivationController extends GetxController {
  Future<MotivationResponse> getMotivation() async {
    final response = await http.get(
      Uri.parse('http://192.168.100.140:8000/api/motivation/'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MotivationResponse.fromJson(data);
    } else {
      throw Exception('Gagal memuat data motivasi');
    }
  }
}
