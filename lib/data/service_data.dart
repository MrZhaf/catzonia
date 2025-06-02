import '../models/service_item.dart';

final List<ServiceItem> groomingServices = [
  ServiceItem(name: 'Basic Grooming', price: 30.0, type: 'grooming'),
  ServiceItem(name: 'Full Grooming', price: 60.0, type: 'grooming'),
  ServiceItem(name: 'Flea Treatment', price: 20.0, type: 'grooming'),
  ServiceItem(name: 'Nail Clipping', price: 15.0, type: 'grooming'),
];

final List<ServiceItem> boardingServices = [
  ServiceItem(name: 'Standard Boarding', price: 40.0, type: 'boarding'),
  ServiceItem(name: 'Luxury Boarding', price: 80.0, type: 'boarding'),
];
