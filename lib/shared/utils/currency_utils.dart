// LAYER: Shared / Utils
// PURPOSE: Currency formatting helpers for the Finance feature.
//          Default currency is PKR. Format amounts for display — never do this in screens.

class CurrencyUtils {
  static const String defaultCurrency = 'PKR';

  /// Format a double to a display string: 'PKR 1,250'
  static String format(double amount, {String currency = defaultCurrency}) {
    final formatted = amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '$currency $formatted';
  }

  /// Format without currency symbol: '1,250'
  static String formatNumber(double amount) {
    return amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
  }
}
