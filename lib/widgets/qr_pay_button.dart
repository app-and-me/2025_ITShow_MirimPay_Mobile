import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/service/auth_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:mirim_pay/app/data/models/card_model.dart' as card_model;

class QrPayButton extends StatelessWidget {
  final bool isDisabled;
  final card_model.Card card;
  final VoidCallback? onTap;

  const QrPayButton({
    super.key,
    this.isDisabled = false,
    required this.card,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return QrPaymentDialog(card: card);
                },
              );
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
        decoration: BoxDecoration(
          color: colors.gray50,
          border: Border.all(
            color: isDisabled ? colors.primaryLight : colors.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/pay.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isDisabled ? colors.primaryLightActive : colors.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'QR 결제',
              style: Typo.bodySm(
                context,
                color: isDisabled ? colors.primaryLightActive : colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QrPaymentDialog extends StatefulWidget {
  final card_model.Card card;

  const QrPaymentDialog({
    super.key,
    required this.card,
  });

  @override
  State<QrPaymentDialog> createState() => _QrPaymentDialogState();
}

class _QrPaymentDialogState extends State<QrPaymentDialog> {
  String? _accessToken;
  Timer? _tokenRefreshTimer;
  Timer? _countdownTimer;
  bool _isLoading = true;
  String? _error;
  int _remainingSeconds = 15 * 60;
  DateTime? _tokenLoadTime;

  @override
  void initState() {
    super.initState();
    _loadAccessToken();
    _startTokenRefreshTimer();
  }

  @override
  void dispose() {
    _tokenRefreshTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadAccessToken() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      final token = await auth.getAccessToken();
      
      if (mounted) {
        setState(() {
          _accessToken = token;
          _isLoading = false;
          _tokenLoadTime = DateTime.now();
          _remainingSeconds = 15 * 60;
        });
        _startCountdownTimer();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Error loading access token';
          _isLoading = false;
        });
      }
    }
  }

  void _startTokenRefreshTimer() {
    _tokenRefreshTimer = Timer.periodic(const Duration(minutes: 15), (timer) {
      if (mounted) {
        _loadAccessToken();
      }
    });
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 340,
        padding: const EdgeInsets.only(bottom: 24, left: 28, right: 28, top: 28),
        decoration: BoxDecoration(
          color: colors.gray50,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
          border: Border.all(
            color: colors.gray300,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'QR 결제',
                  style: Typo.headlineLg(context, color: colors.gray800),
                ),
                if (!_isLoading && _accessToken != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _remainingSeconds < 60 ? colors.primaryLight : colors.gray200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _formatTime(_remainingSeconds),
                      style: Typo.bodySm(
                        context,
                        color: _remainingSeconds < 60 ? colors.primary : colors.gray600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            _buildQrCode(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildQrCode(ThemeColors colors) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Text(
                _error!,
                style: TextStyle(color: colors.gray600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadAccessToken,
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }
    
    if (_accessToken == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Text('토큰을 불러올 수 없습니다'),
        ),
      );
    }
    
    return Column(
      children: [
        QrImageView(
          data: '{"billingKey" : "${widget.card.billingKey}", "customerKey" : "${widget.card.customerKey}", "accessToken" : "$_accessToken"}',
          version: QrVersions.auto,
          backgroundColor: colors.gray50,
          foregroundColor: colors.gray900,
        ),
        const SizedBox(height: 16),
        Text(
          _remainingSeconds < 60 
            ? '곧 새로운 QR 코드가 생성됩니다'
            : 'QR 코드는 ${_formatTime(_remainingSeconds)} 후 갱신됩니다',
          style: Typo.bodySm(
            context,
            color: _remainingSeconds < 60 ? colors.primary : colors.gray500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
