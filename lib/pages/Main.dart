import 'package:flutter/material.dart';
import 'package:mirim_pay/pages/main/ProductPage.dart';
import 'package:mirim_pay/pages/main/PayPage.dart';
import 'package:mirim_pay/pages/main/ContactUsPage.dart';
import 'package:mirim_pay/pages/main/MePage.dart';
import 'package:mirim_pay/widgets/MyBottomNavigationBar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final pages = [
    const PayPage(),
    const ProductPage(),
    const ContactUsPage(),
    const MePage(),
  ];

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: pages[_currentIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}