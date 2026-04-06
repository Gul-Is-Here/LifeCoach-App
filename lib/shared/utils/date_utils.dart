// LAYER: Shared / Utils
// PURPOSE: Date helpers used across all features.
//          Firestore stores dates as 'yyyy-MM-dd' strings — use these helpers everywhere.

class AppDateUtils {
  /// Today as a Firestore-safe string: '2026-04-07'
  static String get todayKey {
    final now = DateTime.now();
    return _format(now);
  }

  /// Format any DateTime to 'yyyy-MM-dd'
  static String format(DateTime date) => _format(date);

  /// Parse a 'yyyy-MM-dd' string back to DateTime
  static DateTime parse(String key) => DateTime.parse(key);

  /// Check if a 'yyyy-MM-dd' string represents today
  static bool isToday(String key) => key == todayKey;

  /// Return the last [days] date keys including today, newest first
  static List<String> lastDays(int days) {
    final today = DateTime.now();
    return List.generate(
      days,
      (i) => _format(today.subtract(Duration(days: i))),
    );
  }

  static String _format(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
