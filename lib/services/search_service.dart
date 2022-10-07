import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setSearchHistory(String text) async {
    final prefs = await _prefs;
    List<String> searchHistory = await getSearchHistory();

    if (searchHistory.isEmpty) {
      searchHistory.insert(0, text);
    } else {
      final index = searchHistory.indexOf(text);
      if (index != 0) {
        if (index != -1) searchHistory.removeAt(index);
        searchHistory.insert(0, text);
      }
    }

    prefs.setStringList('search_history', searchHistory);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await _prefs;
    List<String>? searchHistory = prefs.getStringList('search_history');

    return searchHistory ?? [];
  }

  Future<void> clearItemFromSearchHistory(String text) async {
    final prefs = await _prefs;
    List<String> searchHistory = await getSearchHistory();

    if (searchHistory.isNotEmpty) {
      searchHistory = searchHistory..removeWhere((item) => item == text);
    }

    prefs.setStringList('search_history', searchHistory);
  }

  Future<void> clearAllSearchHistory() async {
    final prefs = await _prefs;
    prefs.setStringList('search_history', []);
  }
}
