import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/customer.dart';
import '../models/cart_item.dart';
import '../models/service_item.dart';

class BookingProvider with ChangeNotifier {
  Customer? _customer;
  final List<CartItem> _cartItems = [];

  Customer? get customer => _customer;
  List<CartItem> get cartItems => _cartItems;

  void setCustomer(Customer customer) {
    _customer = customer;
    notifyListeners();
  }

  void addService(ServiceItem service, DateTime? date, [DateTime? endDate]) {
    _cartItems.add(CartItem(service: service, date: date, endDate: endDate));
    notifyListeners();
  }

  void removeService(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void clearCustomer() {
  _customer = null;
  notifyListeners();
}

bool isServiceSelected(String serviceName) {
  return _cartItems.any((item) => item.service.name == serviceName);
}


  double get totalAmount {
    double total = 0;
    for (var item in _cartItems) {
      total += item.totalPrice;
    }
    return total;
  }

  String generateBookingId() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMddHHmmss');
    return 'CATZ${formatter.format(now)}';
  }

  void updateCustomer(Customer newCustomer) {
    _customer = newCustomer;
    notifyListeners();
  }

  void updateCartItemDate(CartItem item, DateTime newDate, [DateTime? newEndDate]) {
    final index = _cartItems.indexOf(item);
    if (index != -1) {
      _cartItems[index].date = newDate;
      _cartItems[index].endDate = newEndDate;
      notifyListeners();
    }
  }
}
