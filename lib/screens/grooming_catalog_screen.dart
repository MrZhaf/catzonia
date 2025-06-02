import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/service_item.dart';
import '../providers/booking_provider.dart';
import '../screens/boarding_catalog_screen.dart';
import '../screens/checkout_screen.dart';
import '../widgets/service_card.dart';


class GroomingCatalogScreen extends StatefulWidget {
  @override
  _GroomingCatalogScreenState createState() => _GroomingCatalogScreenState();
}

class _GroomingCatalogScreenState extends State<GroomingCatalogScreen> {
  DateTime? _selectedDate;
  final List<ServiceItem> groomingServices = [
    ServiceItem(name: 'Basic Grooming', price: 30.0, type: 'grooming'),
    ServiceItem(name: 'Full Grooming', price: 60.0, type: 'grooming'),
    ServiceItem(name: 'Flea Treatment', price: 20.0, type: 'grooming'),
    ServiceItem(name: 'Nail Clipping', price: 15.0, type: 'grooming'),
  ];

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addToCart(ServiceItem service) {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an appointment date first')),
      );
      return;
    }

    Provider.of<BookingProvider>(context, listen: false)
        .addService(service, _selectedDate);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${service.name} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<BookingProvider>(context).customer;

    return Scaffold(
      appBar: AppBar(
  centerTitle: true,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        'assets/images/catzonia.png',
        height: 64,
      ),
      const SizedBox(width: 10),
      const Text(
        'Grooming Service',
        style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),
      ),
    ],
  ),
),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (customer != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi ${customer.ownerName}, please choose a grooming service:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Appointment Date: ',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    _selectedDate != null
                        ? DateFormat.yMMMd().format(_selectedDate!)
                        : 'Select Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
       Expanded(
          child: ListView.builder(
            itemCount: groomingServices.length,
              itemBuilder: (context, index) {
                final service = groomingServices[index];
                   return ServiceCard(
                     service: service,
                         onAdd: () => _addToCart(service),
                         backgroundColor: Color(0xFFEBB515),
                        );
                      },
                    ),
                  ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                   style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEBB515), // Yellow button color
                  foregroundColor: Colors.black, 
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BoardingCatalogScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.pets),
                  label: Text('Add Boarding'),
                ),
                ElevatedButton.icon(
                   style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEBB515), // Yellow button color
                  foregroundColor: Colors.black, 
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CheckoutScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_cart_checkout),
                  label: Text('Checkout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
