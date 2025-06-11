import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/service_item.dart';
import '../providers/booking_provider.dart';
// import '../screens/checkout_screen.dart';
import '../widgets/service_card.dart';

class BoardingCatalogScreen extends StatefulWidget {
  @override
  _BoardingCatalogScreenState createState() => _BoardingCatalogScreenState();
}

class _BoardingCatalogScreenState extends State<BoardingCatalogScreen> {
  DateTime? _date;
  DateTime? _endDate;

  final List<ServiceItem> boardingServices = [
    ServiceItem(name: 'Standard Boarding', price: 40.0, type: 'boarding'),
    ServiceItem(name: 'Luxury Boarding', price: 80.0, type: 'boarding'),
  ];

  void _pickdate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
        if (_endDate != null && _endDate!.isBefore(_date!)) {
          _endDate = null;
        }
      });
    }
  }

  void _pickEndDate(BuildContext context) async {
    if (_date == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select start date first')),
      );
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: _date!.add(Duration(days: 1)),
      firstDate: _date!,
      lastDate: _date!.add(Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  void _addBoardingToCart(ServiceItem service) {
    if (_date == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both start and end dates')),
      );
      return;
    }

    Provider.of<BookingProvider>(context, listen: false)
        .addService(service, _date, _endDate);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${service.name} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMd();

   return Scaffold(
      backgroundColor: Color(0xFFFFF8E1),
    appBar: AppBar(
      backgroundColor: Color(0xFFEBB515),
    centerTitle: true, // centers the title content
    title: Row(
      mainAxisSize: MainAxisSize.min, // makes the Row shrink to content width
      mainAxisAlignment: MainAxisAlignment.center, // centers children inside Row
      children: [
        Image.asset(
          'assets/images/catzonia2.png', // same logo as Grooming page
          height: 64,
        ),
        const SizedBox(width: 10),
        const Text(
          'Boarding Services',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ),
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.calendar_month),
            Text(' Start Date: ', style: TextStyle(fontSize: 16)),
            TextButton(
              onPressed: () => _pickdate(context),
              child: Text(
                _date != null
                    ? formatter.format(_date!)
                    : 'Select Start Date',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.calendar_month),
            Text(' End Date: ', style: TextStyle(fontSize: 16)),
            TextButton(
              onPressed: () => _pickEndDate(context),
              child: Text(
                _endDate != null
                    ? formatter.format(_endDate!)
                    : 'Select End Date',
              ),
            ),
          ],
        ),
            SizedBox(height: 16),
            Expanded(
          child: ListView.builder(
            itemCount: boardingServices.length,
              itemBuilder: (context, index) {
                 final service = boardingServices[index];
                    final isSelected = Provider.of<BookingProvider>(context).isServiceSelected(service.name);

                    return ServiceCard(
                      service: service,
                      onAdd: isSelected ? null : () => _addBoardingToCart(service), // disable button if selected
                      backgroundColor: isSelected ? Colors.grey.shade300 : Color(0xFFEBB515),
                    );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
