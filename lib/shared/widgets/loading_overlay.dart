// LAYER: Shared / Widgets
// PURPOSE: Full-screen semi-transparent overlay shown while async operations are in progress.
//          Wrap the page Scaffold body with Stack and place this on top when isLoading is true.
// USAGE:   if (controller.isLoading.value) const LoadingOverlay()

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.45),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}
