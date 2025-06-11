import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';
import '../providers/booking_provider.dart';
import 'tabbedscreen.dart'; // Adjust path if needed

class CustomerFormScreen extends StatefulWidget {
  @override
  _CustomerFormScreenState createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ownerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _catNameController = TextEditingController();
  final _breedController = TextEditingController();

  @override
  void dispose() {
    _ownerNameController.dispose();
    _phoneController.dispose();
    _catNameController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: Color(0xFFEBB515),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/catzonia2.png',
              height: 64,
            ),
            const SizedBox(width: 10),
            const Text(
              'Customer Info',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _ownerNameController,
                decoration: InputDecoration(labelText: 'Owner Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter owner name' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter phone number' : null,
              ),
              TextFormField(
                controller: _catNameController,
                decoration: InputDecoration(labelText: 'Cat Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter cat name' : null,
              ),
              TextFormField(
                controller: _breedController,
                decoration: InputDecoration(labelText: 'Cat Breed'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter cat breed' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEBB515),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final customer = Customer(
                      ownerName: _ownerNameController.text,
                      phone: _phoneController.text,
                      catName: _catNameController.text,
                      breed: _breedController.text,
                    );

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Save?'),
                        content:
                            Text('Are you sure you want to save this customer?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<BookingProvider>(context,
                                      listen: false)
                                  .setCustomer(customer);
                              Navigator.pop(context); // Close dialog
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      TabbedGroomingScreen(initialIndex: 1),
                                ),
                              );
                            },
                            child: Text('Yes, Save'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Save and Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
