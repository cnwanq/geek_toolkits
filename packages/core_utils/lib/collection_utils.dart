// lib/core_utils/collection_utils.dart
class CollectionUtils {
  /// 判断集合是否为空
  static bool isNullOrEmpty(Iterable? iterable) =>
      iterable == null || iterable.isEmpty;

  /// 判断 Map 是否为空
  static bool isMapNullOrEmpty(Map? map) => map == null || map.isEmpty;

  /// 去重 List
  static List<T> unique<T>(List<T> list) => list.toSet().toList();

  /// 安全获取 List 元素，越界时返回 null
  static T? safeGet<T>(List<T> list, int index) =>
      (index >= 0 && index < list.length) ? list[index] : null;

  /// 将 List 按指定大小分组
  static List<List<T>> chunk<T>(List<T> list, int size) {
    if (size <= 0) throw ArgumentError('size must be greater than 0');
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += size) {
      chunks.add(
        list.sublist(i, i + size > list.length ? list.length : i + size),
      );
    }
    return chunks;
  }

  /// 扁平化二维 List
  static List<T> flatten<T>(List<List<T>> list) =>
      list.expand((e) => e).toList();

  /// 统计元素出现次数
  static Map<T, int> countBy<T>(Iterable<T> items) {
    final Map<T, int> counts = {};
    for (var item in items) {
      counts[item] = (counts[item] ?? 0) + 1;
    }
    return counts;
  }

  /// 过滤掉 null 元素
  static List<T> filterNotNull<T>(Iterable<T?> items) =>
      items.whereType<T>().toList();

  /// 交换 List 中两个元素的位置
  static void swap<T>(List<T> list, int i, int j) {
    if (i < 0 || j < 0 || i >= list.length || j >= list.length) return;
    final temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }
}
