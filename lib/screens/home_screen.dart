import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/floating_nav_bar.dart';
import 'profile_screen.dart';

/// الغلاف الرئيسي: يعرض محتوى التبويب الحالي + شريط التنقل العائم
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  Widget _body() {
    switch (_tab) {
      case 0:
        return const _HomeContent(key: ValueKey('home'));
      case 3:
        return const ProfileScreen(key: ValueKey('profile'));
      default:
        return _ComingSoon(
          key: ValueKey('tab$_tab'),
          title: FloatingNavBar.items[_tab].label,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSageGrey,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _body(),
            ),
          ),
          PositionedDirectional(
            start: 20,
            end: 20,
            bottom: 0,
            child: SafeArea(
              top: false,
              minimum: const EdgeInsets.only(bottom: 16),
              child: FloatingNavBar(
                currentIndex: _tab,
                onTap: (i) => setState(() => _tab = i),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title - قريباً',
        style: const TextStyle(
          color: AppColors.textDarkPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // مسافة سفلية ~100 حتى لا يغطي الشريط العائم آخر بطاقة
      padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(),
          const SizedBox(height: 18),
          const _SearchBar(),
          const SizedBox(height: 24),
          const Text(
            'الخدمات',
            style: TextStyle(
              color: AppColors.textDarkPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.15,
            children: const [
              _ServiceCard(
                  title: 'طلب جديد',
                  icon: Icons.note_add_rounded,
                  color: Color(0xFFE0A96D)),
              _ServiceCard(
                  title: 'توصيل سريع',
                  icon: Icons.delivery_dining_rounded,
                  color: Color(0xFF4F9A4B)),
              _ServiceCard(
                  title: 'تتبع شحنة',
                  icon: Icons.location_on_rounded,
                  color: Color(0xFFE0524A)),
              _ServiceCard(
                  title: 'شحن الرصيد',
                  icon: Icons.account_balance_wallet_rounded,
                  color: Color(0xFF6B5FB5)),
            ],
          ),
          const SizedBox(height: 16),
          const _ServicesPanel(),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Icon(icon, size: 21, color: AppColors.textDarkPrimary),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ضع صورة المستخدم هنا لاحقاً: Image.asset('assets/images/avatar.jpg')
        const CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.avatarBgForest,
          child: Icon(Icons.person_rounded, color: AppColors.pureWhite),
        ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'صباح الخير،',
              style: TextStyle(color: AppColors.darkArchCharcoal, fontSize: 12),
            ),
            Text(
              'سري جليخة',
              style: TextStyle(
                color: AppColors.textDarkPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const Spacer(),
        const _CircleIconButton(icon: Icons.notifications_none_rounded),
        const SizedBox(width: 8),
        const _CircleIconButton(icon: Icons.search_rounded),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 32,
      height: 56,
      padding: const EdgeInsetsDirectional.fromSTEB(6, 6, 18, 6),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.darkArchCharcoal,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search_rounded,
                color: AppColors.pureWhite, size: 21),
          ),
          const SizedBox(width: 12),
          const Text(
            'تتبع شحنة',
            style: TextStyle(
              color: AppColors.textDarkPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 26,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 22, color: color),
              ),
              const Spacer(),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                // north_west لا ينعكس تلقائياً ويناسب اتجاه RTL
                child: const Icon(Icons.north_west_rounded,
                    size: 18, color: AppColors.textDarkPrimary),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textDarkPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesPanel extends StatelessWidget {
  const _ServicesPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkServicesPanel,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                  child: _MiniTile(
                      label: 'التذاكر',
                      icon: Icons.confirmation_number_rounded,
                      color: Color(0xFFE0A96D))),
              SizedBox(width: 8),
              Expanded(
                  child: _MiniTile(
                      label: 'الدعم',
                      icon: Icons.support_agent_rounded,
                      color: Color(0xFF4A7FB5))),
              SizedBox(width: 8),
              Expanded(
                  child: _MiniTile(
                      label: 'المدفوعات',
                      icon: Icons.payments_rounded,
                      color: Color(0xFF5E8FB8))),
              SizedBox(width: 8),
              Expanded(
                  child: _MiniTile(
                      label: 'الطرود',
                      icon: Icons.inventory_2_rounded,
                      color: Color(0xFF8DB63C))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text(
              'عرض جميع الخدمات',
              style: TextStyle(
                color: AppColors.textDarkPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniTile extends StatelessWidget {
  const _MiniTile({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: color),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textDarkPrimary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
