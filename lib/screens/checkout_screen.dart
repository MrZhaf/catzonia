import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/booking_provider.dart';
// import '../models/service_item.dart';
import '../widgets/service_card.dart';
import 'package:uuid/uuid.dart';
import 'homepage.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedPayment;

  void _confirmCheckout() {
    if (_selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

   final bookingId = Uuid().v4(); // generates a unique booking ID


    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Booking Confirmed'),
        content: Text('Your booking ID is #$bookingId\nPayment: $_selectedPayment'),
        actions: [
          ElevatedButton(
            onPressed: () {
              final provider = Provider.of<BookingProvider>(context, listen: false);
                provider.clearCart();
                provider.clearCustomer();
                  Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => HomePage()),
             (Route<dynamic> route) => false,
             );
            },
            child: Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);
    final customer = provider.customer;
    final services = provider.cartItems;
    // final formatter = DateFormat.yMMMd();

    double total = 0;
    for (var item in services) {
      if (item.service.type == 'boarding' &&
          item.date != null &&
          item.endDate != null) {
        final days =
            item.endDate!.difference(item.date!).inDays + 1; // inclusive
        total += item.service.price * days;
      } else {
        total += item.service.price;
      }
    }

   return Scaffold(
      backgroundColor: Color(0xFFFFF8E1),
    appBar: AppBar(
        backgroundColor: Color(0xFFEBB515),
    centerTitle: true,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/catzonia2.png',
          height: 64,
        ),
        const SizedBox(width: 10),
        const Text(
          'Checkout',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ),
  body: Padding(
    padding: const EdgeInsets.all(16),
    child: ListView(
      children: [
        if (customer != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Info",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Owner: ${customer.ownerName}"),
              Text("Phone: ${customer.phone}"),
              Text("Cat: ${customer.catName} (${customer.breed})"),
              SizedBox(height: 20),
            ],
          ),
        Text(
          "Selected Services",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...services.map((item) {
          final formatter = DateFormat.yMMMd();

          String subtitle;
          if (item.service.type == 'boarding' &&
              item.date != null &&
              item.endDate != null) {
            final days = item.endDate!.difference(item.date!).inDays + 1;
            subtitle =
                "$days days x RM ${item.service.price.toStringAsFixed(2)} = RM ${(item.service.price * days).toStringAsFixed(2)}\n${formatter.format(item.date!)} to ${formatter.format(item.endDate!)}";
          } else {
            subtitle = "RM ${item.service.price.toStringAsFixed(2)}";
            if (item.appointmentDate != null) {
              subtitle += "\nDate: ${formatter.format(item.appointmentDate!)}";
            }
          }

          return ServiceCard(
            service: item.service,
            backgroundColor: Color(0xFFEBB515), // subtle yellow background for cards
            subtitle: subtitle,
            onDelete: () {
              provider.removeService(item);
            },
          );
        }),
        SizedBox(height: 10),
        Divider(),
        Text(
          "Total: RM ${total.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          "Select Payment Method",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          children: ['Card', 'QR', 'Online Transfer']
              .map((method) => RadioListTile<String>(
                    title: Text(method),
                    value: method,
                    groupValue: _selectedPayment,
                    onChanged: (value) {
                      setState(() {
                        _selectedPayment = value;
                      });
                    },
                  ))
              .toList(),
        ),
        ElevatedButton.icon(
           style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEBB515), // Yellow button color
                  foregroundColor: Colors.black, 
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          onPressed: _confirmCheckout,
          icon: Icon(Icons.check),
          label: Text('Confirm & Checkout'),
        ),
      ],
    ),
  ),
);

  }
}
