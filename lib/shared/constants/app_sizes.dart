// LAYER: Shared / Constants
// PURPOSE: UI spacing, border radii, icon sizes — no magic numbers in screens.
// USAGE:   Padding(padding: EdgeInsets.all(AppSizes.pagePadding))

abstract class AppSizes {
  // ─── Padding / Margin ─────────────────────────────────────────────────────
  static const double pagePadding = 20.0; // horizontal page margin
  static const double cardPadding = 16.0; // inside GlassCard
  static const double itemSpacing = 12.0; // vertical gap between list items
  static const double sectionGap = 24.0; // gap between page sections

  // ─── Border radius ────────────────────────────────────────────────────────
  static const double radiusCard = 16.0;
  static const double radiusButton = 12.0;
  static const double radiusInput = 10.0;
  static const double radiusChip = 24.0; // habit chips, category pills

  // ─── Icons ────────────────────────────────────────────────────────────────
  static const double iconSm = 18.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  // ─── Bottom nav / Dashboard ───────────────────────────────────────────────
  static const double bottomNavHeight = 64.0;
  static const double dailyScoreRingSize = 120.0;
}
