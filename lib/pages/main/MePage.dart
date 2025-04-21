import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    final gray = Gray.of(context);

    return Scaffold(
      backgroundColor: gray.gray50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            '내 정보', 
            style: Typo.headlineLg(context, color: gray.gray900)
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: SvgPicture.asset('assets/icons/alert_default.svg'), // TODO: 알람 여부에 따라 아이콘 변경
              onPressed: () => Get.toNamed('/alert')
            ),
          ],
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/me.svg',
                  width: 36,
                  height: 36,
                  color: gray.gray800,
                ),
                const SizedBox(width: 20),
                Text(
                  '1000 김미림',
                  style: Typo.bodyMd(context, color: gray.gray800),
                ),
              ],
            ),
          ),
          const SizedBox(height: 59),
          Container(
            width: double.infinity,
            height: 4,
            color: gray.gray100,
          ),
          const SizedBox(height: 16),
          // TODO: 세부 정보 페이지로 이동
          MenuListItem(
            title: '결제 내역',
            onTap: () {},
          ),
          MenuListItem(
            title: '카드 정보',
            onTap: () {
            },
          ),
          MenuListItem(
            title: '얼굴 결제 등록',
            onTap: () {
            },
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 4,
            color: gray.gray100,
          ),
        ],
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MenuListItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gray = Gray.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Typo.bodyMd(context, color: gray.gray800).copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              color: gray.gray500,
              width: 16,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}