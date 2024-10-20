import 'package:flutter/foundation.dart';
import '../helpers/generate_menu.dart';
import '../models/category_menu.dart';
import '../models/order_item.dart';

class OrderStore extends ChangeNotifier {
  final List<CategoryMenu> _listMenu = GenerateMenu.generateMenu();
  final List<OrderItem> _items = [];

  List<OrderItem> get items => _items;

  List<CategoryMenu> get listMenu => _listMenu;

  void addItem(OrderItem item) {
    int index = _items.indexWhere((existingItem) => existingItem.name == item.name);

    if (index >= 0) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }

    notifyListeners();
  }

  void removeItem(OrderItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateItemQuantity(OrderItem item, int quantity) {
    int index = _items.indexWhere((existingItem) => existingItem.name == item.name);

    if (index >= 0) {
      _items[index].quantity = quantity;
    }

    notifyListeners();
  }

  double get total => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
