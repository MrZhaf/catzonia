import 'package:flutter/material.dart';
import 'boarding_catalog_screen.dart';
import 'grooming_catalog_screen.dart';
import 'checkout_screen.dart';

class TabbedGroomingScreen extends StatefulWidget {
  final int initialIndex;

  const TabbedGroomingScreen({Key? key, this.initialIndex = 1}) : super(key: key);

  @override
  _TabbedGroomingScreenState createState() => _TabbedGroomingScreenState();
}

class _TabbedGroomingScreenState extends State<TabbedGroomingScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Use initialIndex from constructor
  }

  final List<Widget> _pages = [
    BoardingCatalogScreen(),
    GroomingCatalogScreen(),
    CheckoutScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
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
