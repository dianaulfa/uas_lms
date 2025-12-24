class NotificationService {
  NotificationService._privateConstructor();
  static final NotificationService instance = NotificationService._privateConstructor();

  final List<Map<String, String>> _items = [];

  List<Map<String, String>> get items => List.unmodifiable(_items);

  void add(String title) {
    _items.insert(0, {'title': title, 'time': 'Baru Saja'});
  }

  void clear() => _items.clear();
}
