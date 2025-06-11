import 'package:catzonia/providers/booking_provider.dart';
import 'package:catzonia/screens/customer_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/grooming_catalog_screen.dart';
import 'screens/homepage.dart';
import 'screens/boarding_catalog_screen.dart';
import 'screens/checkout_screen.dart';

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
        home: HomePage(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CustomerFormScreen(),
    BoardingCatalogScreen(),
    GroomingCatalogScreen(),
    CheckoutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: 'Boarding',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cut),
            label: 'Grooming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
