import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/booking_provider.dart';
import 'screens/customer_form_screen.dart';

void main() {
  runApp(CatzoniaApp());
}

class CatzoniaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Catzonia POS',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: CustomerFormScreen(),
      ),
    );
  }
}
