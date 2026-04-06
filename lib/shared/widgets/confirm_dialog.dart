// LAYER: Shared / Widgets
// PURPOSE: Standard confirmation bottom-sheet/dialog used for destructive actions
//          (delete habit, delete expense, etc.).
//          Never use raw showDialog in features — always use this widget.
// USAGE:
//   ConfirmDialog.show(
//     title: 'Delete habit?',
//     message: 'This will remove all streak data.',
//     onConfirm: () => controller.deleteHabit(id),
//   );

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';

class ConfirmDialog {
  static Future<void> show({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmLabel = AppStrings.delete,
    Color confirmColor = AppColors.error,
  }) {
    return Get.defaultDialog(
      backgroundColor: AppColors.cardDark,
      title: title,
      titleStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      middleText: message,
      middleTextStyle: const TextStyle(color: AppColors.textSecondary),
      radius: AppSizes.radiusCard,
      textConfirm: confirmLabel,
      textCancel: AppStrings.cancel,
      confirmTextColor: Colors.white,
      cancelTextColor: AppColors.textSecondary,
      buttonColor: confirmColor,
      onConfirm: () {
        Get.back();
        onConfirm();
      },
    );
  }
}
