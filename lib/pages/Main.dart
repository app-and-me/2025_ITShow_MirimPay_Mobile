import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/product_page.dart';
import 'package:mirim_pay/pages/main/pay_page.dart';
import 'package:mirim_pay/pages/main/contactus_page.dart';
import 'package:mirim_pay/pages/main/me_page.dart';
import 'package:mirim_pay/pages/main/viewmodels/pay_page_viewmodel.dart';
import 'package:mirim_pay/pages/main/viewmodels/product_page_viewmodel.dart';
import 'package:mirim_pay/pages/main/viewmodels/contactus_page_viewmodel.dart';
import 'package:mirim_pay/pages/main/viewmodels/me_page_viewmodel.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/widgets/my_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    
    pages = [
      const PayPage(),
      const ProductPage(),
      const ContactUsPage(),
      const MePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {   
    ThemeColors colors = ThemeColors.of(context); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.gray50,
        toolbarHeight: 18,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: colors.gray50,
      extendBody: true,
      body: pages[_currentIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          
          _refreshNotificationStatus(index);
        },
      ),
    );
  }
  
  void _refreshNotificationStatus(int pageIndex) {
    try {
      if (pageIndex == 0 && Get.isRegistered<PayPageViewModel>()) {
        final payController = Get.find<PayPageViewModel>();
        payController.loadNotificationStatus();
      }
      
      if (pageIndex == 1 && Get.isRegistered<ProductPageViewModel>()) {
        final productController = Get.find<ProductPageViewModel>();
        productController.refreshData();
      }
      
      if (pageIndex == 2 && Get.isRegistered<ContactUsPageViewModel>()) {
        final contactUsController = Get.find<ContactUsPageViewModel>();
        contactUsController.refreshData();
      }
      
      if (pageIndex == 3 && Get.isRegistered<MePageViewModel>()) {
        final meController = Get.find<MePageViewModel>();
        meController.loadNotificationStatus();
      }
    } catch (_) {
    }
  }
}