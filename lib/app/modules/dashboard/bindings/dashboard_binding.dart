import 'package:get/get.dart';
import 'package:ujikom_selpi/app/modules/motivation/controllers/motivation_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
      Get.lazyPut<MotivationController>(() => MotivationController());
    // Tambahkan controller lain juga kalau perlu
  }
}
