import 'middleware.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 持久化中间件
class PersistMiddleware<T> implements StateMiddleware<T> {
  final String key;
  final T Function(String) fromJson;
  final String Function(T) toJson;

  PersistMiddleware(this.key, {required this.fromJson, required this.toJson});

  @override
  void onChange(T oldValue, T newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, toJson(newValue));
  }
} 