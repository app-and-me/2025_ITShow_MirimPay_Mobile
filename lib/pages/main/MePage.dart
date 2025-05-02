import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_oauth_flutter/mirim_oauth_flutter.dart';
import 'package:mirim_pay/util/service/AuthService.dart';
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
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            '내 정보', 
            style: Typo.headlineLg(context, color: colors.gray900)
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/alert_default.svg',
                color: colors.gray900,
              ), // TODO: 알람 여부에 따라 아이콘 변경
              onPressed: () => Get.toNamed('/alert')
            ),
          ],
          backgroundColor: colors.gray50,
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
                  color: colors.gray800,
                ),
                const SizedBox(width: 20),
                Text(
                  auth.currentUser?.nickname ?? '이름',
                  style: Typo.bodyMd(context, color: colors.gray800),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/arrow_right.svg',
                  color: colors.gray900,
                  width: 16,
                  height: 16,
                )
              ],
            ),
          ),
          const SizedBox(height: 42),
          Container(
            width: double.infinity,
            height: 4,
            color: colors.gray300,
          ),
          const SizedBox(height: 16),
          // TODO: 탭 안으로 이동 기능
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
            color: colors.gray300,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () async {
                    await auth.logOut();
                    Get.offAllNamed('/login');
                },
                child: Text(
                  '로그아웃',
                  style: Typo.bodyMd(context, color: colors.gray400).copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
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
    final colors = ThemeColors.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Typo.bodyMd(context, color: colors.gray800).copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              color: colors.gray400,
              width: 16,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}