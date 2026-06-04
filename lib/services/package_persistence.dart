import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tracking_entry.dart';

/// Manages locally saved tracking history entries.
class TrackingHistory {
  static const _key = 'tracking_history';

  static final TrackingHistory _instance = TrackingHistory._internal();
  factory TrackingHistory() => _instance;
  TrackingHistory._internal();

  /// Save a tracking entry to history
  Future<void> saveEntry(TrackingEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await loadEntries();

    // Remove if already exists (move to top)
    entries.removeWhere((e) => e.id == entry.id);
    entries.insert(0, entry);

    final jsonList = entries.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  /// Load all saved tracking entries
  Future<List<TrackingEntry>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];

    return jsonList.map((j) {
      final map = jsonDecode(j) as Map<String, dynamic>;
      return TrackingEntry.fromJson(map);
    }).toList();
  }

  /// Remove a tracking entry
  Future<void> removeEntry(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await loadEntries();
    entries.removeWhere((e) => e.id == id);

    final jsonList = entries.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  /// Clear all history
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
