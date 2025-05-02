import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/colors.dart';
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
    ThemeColors colors = ThemeColors.of(context);
    
    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: AppBar(
        backgroundColor: colors.gray50,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
            width: 24,
            height: 24,
            color: colors.gray900,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '알림', 
          style: Typo.headlineSub(context, color: colors.gray900),
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
