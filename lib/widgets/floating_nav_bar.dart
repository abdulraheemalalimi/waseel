import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// بطاقة زجاجية مشتركة: التمويه داخل ClipRRect لقصه بدقة وحماية الأداء
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.radius = 28,
    this.padding = const EdgeInsets.all(14),
    this.height,
  });

  final Widget child;
  final double radius;
  final EdgeInsetsGeometry padding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: borderRadius,
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class NavItemData {
  const NavItemData(this.icon, this.label);
  final IconData icon;
  final String label;
}

/// شريط التنقل العائم (الكبسولة البيضاء النشطة مع توهج ليموني)
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  // الترتيب في RTL من اليمين: الرئيسية، طلباتي، الإشعارات، حسابي
  static const List<NavItemData> items = [
    NavItemData(Icons.home_outlined, 'الرئيسية'),
    NavItemData(Icons.assignment_outlined, 'طلباتي'),
    NavItemData(Icons.notifications_none_rounded, 'الإشعارات'),
    NavItemData(Icons.person_outline_rounded, 'حسابي'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.floatingNavBlack,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (i) {
          final active = i == currentIndex;
          final item = items[i];
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              height: 46,
              constraints: const BoxConstraints(minWidth: 46),
              padding: EdgeInsetsDirectional.symmetric(horizontal: active ? 16 : 0),
              decoration: BoxDecoration(
                color: active ? AppColors.pureWhite : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: active ? AppColors.neonLimeAccent : Colors.transparent,
                  width: 1.5,
                ),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: AppColors.neonLimeGlow.withValues(alpha: 0.55),
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ]
                    : const [],
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      size: 22,
                      color: active ? AppColors.botanicalGreenMid : AppColors.pureWhite,
                    ),
                    if (active) ...[
                      const SizedBox(width: 8),
                      Text(
                        item.label,
                        style: const TextStyle(
                          color: AppColors.textDarkPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
