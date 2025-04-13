import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    return Obx(
      () => Scaffold(
        body: Navigator(
          key: Get.nestedKey(1),
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (_) => controller.pages[controller.selectedIndex.value],
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
            Get.nestedKey(1)!.currentState!.pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => controller.pages[index],
                  ),
                );
          },
          type: BottomNavigationBarType.fixed, // tambahkan ini
          selectedItemColor: Colors.blue, // warna icon/text saat aktif
          unselectedItemColor: Colors.grey, // warna icon/text saat tidak aktif
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Index',
            ),
           
            BottomNavigationBarItem(
              icon: Icon(Icons.apartment),
              label: 'Perusahaan',
            ), BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Motivasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
