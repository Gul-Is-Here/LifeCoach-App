// LAYER: Shared / Constants
// PURPOSE: Single source of truth for every color in the app.
//          Dark-only theme for MVP. Never hardcode Color() values in screens.
// USAGE:   Container(color: AppColors.cardDark)

import 'package:flutter/material.dart';

abstract class AppColors {
  // ─── Brand ───────────────────────────────────────────────────────────────
  static const primary = Color(0xFF7C3AED); // purple — buttons, active states
  static const primaryLight = Color(0xFF9F67FF); // lighter purple — highlights

  // ─── Backgrounds ─────────────────────────────────────────────────────────
  static const backgroundDark = Color(0xFF0F0F1A); // main scaffold background
  static const cardDark = Color(0xFF1A1A2E); // GlassCard, bottom sheets
  static const surfaceDark = Color(0xFF16213E); // input fields, secondary cards

  // ─── Text ─────────────────────────────────────────────────────────────────
  static const textPrimary = Color(0xFFE8E8F0); // headings, body text
  static const textSecondary = Color(0xFF8F8FA8); // subtitles, captions, hints

  // ─── Semantic ─────────────────────────────────────────────────────────────
  static const success = Color(0xFF34D399); // habit streak, goal complete
  static const warning = Color(0xFFFBBF24); // budget 80% alert
  static const error = Color(0xFFF87171); // budget exceeded, auth error
  static const info = Color(0xFF60A5FA); // AI coach messages

  // ─── Priority dots (Planner) ──────────────────────────────────────────────
  static const urgent = Color(0xFFF87171); // red
  static const high = Color(0xFFFBBF24); // yellow
  static const medium = Color(0xFF60A5FA); // blue
  static const low = Color(0xFF6B7280); // grey
}
