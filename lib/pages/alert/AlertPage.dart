import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/typography.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '알림', 
          style: Typo.headlineSub(context, color: Colors.black),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: const Center(
        child: Text('Alert Page'),
      ),
    );
  }
}
