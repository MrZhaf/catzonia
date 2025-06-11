import 'package:flutter/material.dart';
import 'customer_form_screen.dart'; // Make sure the path is correct

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E1), // Light warm background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
              'assets/images/catzonia2.png',
              height: 200,
            ),
              SizedBox(height: 20),
              Text(
                'Welcome to Catzonia POS!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Your pet’s grooming & boarding assistant.',
                style: TextStyle(fontSize: 16, color: Colors.brown.shade400),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                icon: Icon(Icons.pets),
                label: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEBB515),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CustomerFormScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
