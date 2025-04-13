import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom_selpi/app/data/motivation_response.dart';
import 'package:ujikom_selpi/app/utils/api.dart';

class MotivationController extends GetxController {
   final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  Future<MotivationResponse> getMotivation() async {
    try {
      final response = await _getConnect.get(
        BaseUrl.motivation,
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'application/json',
      );

      return MotivationResponse.fromJson(response.body);
    } catch (e) {
      throw Exception('Gagal memuat motivasi: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMotivation();
  }
}
