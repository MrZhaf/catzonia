import 'service_item.dart';

class CartItem {
  final ServiceItem service;
  DateTime? date; // for grooming or start of boarding
  DateTime? endDate; // only for boarding

  CartItem({
    required this.service,
    this.date,
    this.endDate,
  });

  /// Getter to standardize date display for all services
  DateTime? get appointmentDate {
    return date;
  }

  int get totalDays {
    if (service.type == 'boarding' && date != null && endDate != null) {
      return endDate!.difference(date!).inDays;
    }
    return 0;
  }

  double get totalPrice {
    if (service.type == 'boarding') {
      return service.price * totalDays;
    }
    return service.price;
  }
}
