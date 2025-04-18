import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_selpi/app/modules/dashboard/views/index_view.dart';
import 'package:ujikom_selpi/app/modules/dashboard/views/profile_view.dart';
import 'package:ujikom_selpi/app/modules/motivation/views/motivation_view.dart';
import 'package:ujikom_selpi/app/modules/perusahaan/views/perusahaan_view.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(), 
    PerusahaanView(),
    MotivationView(),
    ProfileView(),
   
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}