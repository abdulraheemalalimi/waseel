import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/waseel_arch_clipper.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _goHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final panelHeight = math.max(height * 0.52, 400.0);

    return Scaffold(
      backgroundColor: AppColors.bgSageGrey,
      body: Stack(
        children: [
          // الجزء العلوي: الشعار + الرسم التوضيحي
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const _Logo(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: panelHeight * 0.12),
                      child: const _Hero(),
                    ),
                  ),
                  SizedBox(height: panelHeight * 0.8),
                ],
              ),
            ),
          ),
          // اللوحة الداكنة المقوّسة
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: panelHeight,
            child: ClipPath(
              clipper: WaseelArchClipper(),
              child: Container(
                color: AppColors.darkArchCharcoal,
                padding: EdgeInsets.fromLTRB(24, panelHeight * 0.2, 24, 0),
                child: SafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const _Dots(activeIndex: 2, count: 4),
                      const SizedBox(height: 22),
                      const Text(
                        'سريع، آمن، وفي الوقت دائماً',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: 25,
                          height: 1.4,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'توصيل شحناتك بأمان وسرعة فائقة.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textMutedSubtitle,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 26),
                      _SwipeToStart(onCompleted: () => _goHome(context)),
                    ],
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

/// شعار وصل: علامة ليمونية + نص
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(size: const Size(38, 40), painter: _LogoMarkPainter()),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'وصل',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: 36,
                height: 1.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'WASEEL',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontSize: 15,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LogoMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.neonLimeAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.height * 0.17;
    final h = size.height;
    final w = size.width;
    canvas.drawLine(Offset(w * 0.30, h * 0.14), Offset(w * 0.95, h * 0.14), p);
    canvas.drawLine(Offset(w * 0.05, h * 0.50), Offset(w * 0.95, h * 0.50), p);
    canvas.drawLine(Offset(w * 0.30, h * 0.86), Offset(w * 0.75, h * 0.86), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// الرسم التوضيحي: يحاول تحميل الصورة، وإن لم تكن موجودة يعرض بديلاً رسومياً.
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final size = math.min(c.maxHeight, 280.0);
        return Center(
          // ضع صورتك هنا لاحقاً: assets/images/courier.png
          // (وأزل التعليق عن assets في pubspec.yaml)
          child: Image.asset(
            'assets/images/courier.png',
            height: size,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                _FallbackHero(size: size),
          ),
        );
      },
    );
  }
}

class _FallbackHero extends StatelessWidget {
  const _FallbackHero({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.82,
            height: size * 0.82,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.botanicalGreenTop, AppColors.botanicalGreenMid],
              ),
            ),
          ),
          Icon(Icons.delivery_dining_rounded,
              size: size * 0.6, color: AppColors.pureWhite),
          PositionedDirectional(
            top: size * 0.1,
            end: size * 0.12,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.neonLimeAccent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.inventory_2_rounded,
                  size: size * 0.1, color: AppColors.textDarkPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.activeIndex, required this.count});
  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 24 : 9,
          height: 9,
          decoration: BoxDecoration(
            color: active
                ? AppColors.neonLimeAccent
                : AppColors.textMutedSubtitle.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(6),
          ),
        );
      }),
    );
  }
}

/// شريط "اسحب للبدء": ينزلق الزر الأسود نحو اليسار (في RTL)
class _SwipeToStart extends StatefulWidget {
  const _SwipeToStart({required this.onCompleted});
  final VoidCallback onCompleted;

  @override
  State<_SwipeToStart> createState() => _SwipeToStartState();
}

class _SwipeToStartState extends State<_SwipeToStart> {
  static const double _buttonWidth = 132;
  static const double _buttonHeight = 56;
  static const double _pad = 6;

  double _drag = 0;
  bool _dragging = false;
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final maxDrag = c.maxWidth - _buttonWidth - _pad * 2;
        // في RTL السحب لليسار يعطي dx سالب، لذلك نعكس الإشارة
        final sign =
            Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;

        void finish() {
          if (_done) return;
          _done = true;
          setState(() => _drag = maxDrag);
          widget.onCompleted();
        }

        return GestureDetector(
          onTap: finish,
          onHorizontalDragStart: (_) => setState(() => _dragging = true),
          onHorizontalDragUpdate: (d) => setState(() {
            _drag = (_drag + d.delta.dx * sign).clamp(0.0, maxDrag);
          }),
          onHorizontalDragEnd: (_) {
            setState(() => _dragging = false);
            if (maxDrag > 0 && _drag / maxDrag > 0.65) {
              finish();
            } else {
              setState(() => _drag = 0);
            }
          },
          child: Container(
            height: _buttonHeight + _pad * 2,
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 28),
                    child: Opacity(
                      opacity: (1 - (maxDrag > 0 ? _drag / maxDrag : 0))
                          .clamp(0.0, 1.0),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'اسحب للبدء',
                            style: TextStyle(
                              color: AppColors.textSwipeTrack,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 8),
                          // arrow_forward ينعكس تلقائياً ليشير لليسار في RTL
                          Icon(Icons.arrow_forward_rounded,
                              size: 18, color: AppColors.textSwipeTrack),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositionedDirectional(
                  duration: _dragging
                      ? Duration.zero
                      : const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  start: _pad + _drag,
                  top: _pad,
                  child: Container(
                    width: _buttonWidth,
                    height: _buttonHeight,
                    decoration: BoxDecoration(
                      color: AppColors.ctaButtonBlack,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ابدأ الآن',
                          style: TextStyle(
                            color: AppColors.pureWhite,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded,
                            size: 18, color: AppColors.pureWhite),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
