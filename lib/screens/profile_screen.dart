import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/floating_nav_bar.dart';

/// محتوى تبويب "حسابي" (يُعرض داخل HomeScreen فوق شريط التنقل العائم)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const List<_MenuItem> _items = [
    _MenuItem('تعديل الحساب', Icons.edit_outlined),
    _MenuItem('طلباتي', Icons.assignment_outlined),
    _MenuItem('الإشعارات', Icons.notifications_none_rounded),
    _MenuItem('عناوين الاستلام', Icons.location_on_outlined),
    _MenuItem('الحساب البنكي', Icons.account_balance_outlined),
    _MenuItem('المحافظ الإلكترونية', Icons.account_balance_wallet_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // مسافة سفلية ~100 حتى لا يغطي الشريط العائم آخر عنصر
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 110),
      child: Column(
        children: [
          const _ProfileHeader(),
          const SizedBox(height: 16),
          for (final item in _items) ...[
            _MenuRow(item: item),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem(this.title, this.icon);
  final String title;
  final IconData icon;
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        height: 270,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.botanicalGreenTop,
              AppColors.botanicalGreenMid,
              AppColors.botanicalGreenMid.withValues(alpha: 0.75),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // زخرفة أوراق نباتية خفيفة
            PositionedDirectional(
              top: -10,
              end: -10,
              child: Transform.rotate(
                angle: 0.6,
                child: Icon(Icons.eco_rounded,
                    size: 130, color: Colors.white.withValues(alpha: 0.12)),
              ),
            ),
            PositionedDirectional(
              top: 20,
              start: -20,
              child: Transform.rotate(
                angle: -0.5,
                child: Icon(Icons.eco_rounded,
                    size: 90, color: Colors.white.withValues(alpha: 0.10)),
              ),
            ),
            // الأزرار العلوية: النقاط في البداية (يمين) والقلم في النهاية (يسار)
            const PositionedDirectional(
              top: 14,
              start: 14,
              child: _HeaderButton(icon: Icons.more_horiz_rounded),
            ),
            const PositionedDirectional(
              top: 14,
              end: 14,
              child: _HeaderButton(icon: Icons.edit_outlined),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ضع صورة المستخدم هنا لاحقاً: Image.asset('assets/images/avatar.jpg')
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.avatarBgForest,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.45), width: 3),
                  ),
                  child: const Icon(Icons.person_rounded,
                      size: 56, color: AppColors.pureWhite),
                ),
                const SizedBox(height: 12),
                const Text(
                  'سري جليخة',
                  style: TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  '@srijulaekha',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: AppColors.textMutedSubtitle,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.22),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: AppColors.pureWhite),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.item});
  final _MenuItem item;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 30,
      height: 56,
      padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 8, 6),
      child: Row(
        children: [
          Icon(item.icon, size: 22, color: AppColors.darkArchCharcoal),
          const SizedBox(width: 12),
          Text(
            item.title,
            style: const TextStyle(
              color: AppColors.textDarkPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            // arrow_forward ينعكس تلقائياً ليشير لليسار في RTL
            child: const Icon(Icons.arrow_forward_rounded,
                size: 18, color: AppColors.textDarkPrimary),
          ),
        ],
      ),
    );
  }
}
