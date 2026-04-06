// LAYER: UI (Layer 1) — Onboarding
// PURPOSE: Modern 4-page onboarding. Full-bleed animated gradient background per page,
//          floating glass card, decorative blobs, animated icon, pill progress bar,
//          swipe-aware CTA button. First install only.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/constants/app_sizes.dart';
import '../../shared/constants/app_strings.dart';
import 'onboarding_controller.dart';

// ─── Page data ────────────────────────────────────────────────────────────────
class _PageData {
  const _PageData({
    required this.icon,
    required this.label,
    required this.title,
    required this.body,
    required this.accent,
    required this.bgTop,
    required this.bgBottom,
    required this.stats,
  });
  final String icon;
  final String label;
  final String title;
  final String body;
  final Color accent;
  final Color bgTop;
  final Color bgBottom;
  final List<_Stat> stats;
}

class _Stat {
  const _Stat(this.value, this.label);
  final String value;
  final String label;
}

const _pages = [
  _PageData(
    icon: '✅',
    label: 'HABITS',
    title: 'Build habits\nthat actually stick',
    body:
        'Track streaks, set reminders, and watch your consistency score rise every single day.',
    accent: Color(0xFF7C3AED),
    bgTop: Color(0xFF1A0533),
    bgBottom: Color(0xFF0F0F1A),
    stats: [
      _Stat('21', 'days to\na habit'),
      _Stat('3×', 'more likely\nto succeed'),
      _Stat('∞', 'habits\nto track'),
    ],
  ),
  _PageData(
    icon: '💚',
    label: 'HEALTH',
    title: 'Know your body\nbetter every day',
    body:
        'Log water, sleep, mood and steps in seconds. Spot trends before they become problems.',
    accent: Color(0xFF059669),
    bgTop: Color(0xFF012A1A),
    bgBottom: Color(0xFF0F0F1A),
    stats: [
      _Stat('8', 'glasses\nof water'),
      _Stat('7–9h', 'optimal\nsleep'),
      _Stat('10k', 'daily\nstep goal'),
    ],
  ),
  _PageData(
    icon: '💰',
    label: 'FINANCE',
    title: 'Spend smart,\nsave more',
    body:
        'Set budgets, track every expense, and get alerted before you overspend — no surprises.',
    accent: Color(0xFFD97706),
    bgTop: Color(0xFF2A1500),
    bgBottom: Color(0xFF0F0F1A),
    stats: [
      _Stat('6', 'expense\ncategories'),
      _Stat('80%', 'budget\nalert'),
      _Stat('PKR', 'default\ncurrency'),
    ],
  ),
  _PageData(
    icon: '🤖',
    label: 'AI COACH',
    title: 'Your personal AI\ncoach, always on',
    body:
        'Claude AI reads your real data — habits, sleep, spending — and gives advice that actually fits your life.',
    accent: Color(0xFF2563EB),
    bgTop: Color(0xFF001030),
    bgBottom: Color(0xFF0F0F1A),
    stats: [
      _Stat('20', 'messages\nper day'),
      _Stat('4.6', 'Claude\nSonnet'),
      _Stat('100%', 'private\n& secure'),
    ],
  ),
];

// ─── Screen ───────────────────────────────────────────────────────────────────
class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // ── Animated full-bleed background ──────────────────────────────────
          Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _pages[controller.currentPage.value].bgTop,
                      _pages[controller.currentPage.value].bgBottom,
                    ],
                  ),
                ),
                width: size.width,
                height: size.height,
              )),

          // ── Decorative blobs ────────────────────────────────────────────────
          Obx(() {
            final accent = _pages[controller.currentPage.value].accent;
            return Stack(
              children: [
                Positioned(
                  top: -60,
                  right: -60,
                  child: _Blob(color: accent, size: 220),
                ),
                Positioned(
                  bottom: 80,
                  left: -80,
                  child: _Blob(color: accent, size: 180),
                ),
                Positioned(
                  top: size.height * 0.18,
                  left: size.width / 2 - 130,
                  child: _RingBlob(color: accent, size: 260),
                ),
              ],
            );
          }),

          // ── PageView ────────────────────────────────────────────────────────
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (_, i) => _PageContent(page: _pages[i]),
          ),

          // ── Top bar ─────────────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.pagePadding,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _LabelChip(
                          key: ValueKey(controller.currentPage.value),
                          label: _pages[controller.currentPage.value].label,
                          color: _pages[controller.currentPage.value].accent,
                        ),
                      )),
                  Obx(() => AnimatedOpacity(
                        opacity:
                            controller.currentPage.value < _pages.length - 1
                                ? 1.0
                                : 0.0,
                        duration: const Duration(milliseconds: 250),
                        child: GestureDetector(
                          onTap: controller.skip,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12)),
                            ),
                            child: const Text(
                              AppStrings.onboardingSkip,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),

          // ── Bottom controls ──────────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSizes.pagePadding, 0, AppSizes.pagePadding, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => _ProgressBar(
                          total: _pages.length,
                          current: controller.currentPage.value,
                          accent: _pages[controller.currentPage.value].accent,
                        )),
                    const SizedBox(height: 24),
                    Obx(() => _CTAButton(
                          isLast: controller.currentPage.value ==
                              _pages.length - 1,
                          accent: _pages[controller.currentPage.value].accent,
                          onTap: controller.nextPage,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Page content ─────────────────────────────────────────────────────────────
class _PageContent extends StatelessWidget {
  const _PageContent({required this.page});
  final _PageData page;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 80),

          // ── Floating icon card ───────────────────────────────────────────────
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.7, end: 1.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              builder: (_, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      page.accent.withValues(alpha: 0.30),
                      page.accent.withValues(alpha: 0.10),
                    ],
                  ),
                  border: Border.all(
                    color: page.accent.withValues(alpha: 0.45),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: page.accent.withValues(alpha: 0.25),
                      blurRadius: 40,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    page.icon,
                    style: const TextStyle(fontSize: 72),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 36),

          // ── Text block ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.pagePadding + 4),
            child: Column(
              children: [
                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  page.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary.withValues(alpha: 0.9),
                    fontSize: 15,
                    height: 1.65,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Stat chips ───────────────────────────────────────────────────────
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.pagePadding),
            child: Row(
              children: page.stats
                  .map((s) => Expanded(
                        child: _StatChip(stat: s, accent: page.accent),
                      ))
                  .toList(),
            ),
          ),

          const SizedBox(height: 130),
        ],
      ),
    );
  }
}

// ─── Stat chip ────────────────────────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  const _StatChip({required this.stat, required this.accent});
  final _Stat stat;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Column(
        children: [
          Text(
            stat.value,
            style: TextStyle(
              color: accent,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Label chip (top-left) ────────────────────────────────────────────────────
class _LabelChip extends StatelessWidget {
  const _LabelChip({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ─── Segmented progress bar ───────────────────────────────────────────────────
class _ProgressBar extends StatelessWidget {
  const _ProgressBar(
      {required this.total, required this.current, required this.accent});
  final int total;
  final int current;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final isActive = i <= current;
        final isCurrent = i == current;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 4,
            decoration: BoxDecoration(
              color: isActive
                  ? accent
                  : Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(2),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                          color: accent.withValues(alpha: 0.6),
                          blurRadius: 6)
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

// ─── CTA button ───────────────────────────────────────────────────────────────
class _CTAButton extends StatelessWidget {
  const _CTAButton(
      {required this.isLast, required this.accent, required this.onTap});
  final bool isLast;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        height: 58,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent, accent.withValues(alpha: 0.75)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSizes.radiusButton + 2),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.45),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLast
                  ? AppStrings.onboardingGetStarted
                  : AppStrings.onboardingNext,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isLast
                    ? Icons.rocket_launch_rounded
                    : Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Decorative blob ──────────────────────────────────────────────────────────
class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}

// ─── Ring blob ────────────────────────────────────────────────────────────────
class _RingBlob extends StatelessWidget {
  const _RingBlob({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _RingPainter(color: color),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final cx = size.width / 2;
    final cy = size.height / 2;
    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset(cx, cy),
        (size.width / 2) * (0.5 + i * 0.25),
        paint,
      );
    }

    final dotPaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;
    const dotCount = 8;
    final r = size.width / 2;
    for (var i = 0; i < dotCount; i++) {
      final angle = (2 * math.pi / dotCount) * i;
      canvas.drawCircle(
        Offset(cx + r * math.cos(angle), cy + r * math.sin(angle)),
        2.5,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.color != color;
}
