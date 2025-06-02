import 'package:flutter/material.dart';
import '../models/service_item.dart';

class ServiceCard extends StatelessWidget {
  final ServiceItem service;
  final VoidCallback? onAdd;           // optional, for add button
  final VoidCallback? onDelete;        // optional, for delete button
  final String? subtitle;              // optional custom subtitle
  final Color backgroundColor;

  const ServiceCard({
    Key? key,
    required this.service,
    this.onAdd,
    this.onDelete,
    this.subtitle,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? trailingWidget;

    if (onAdd != null) {
      trailingWidget = IconButton(
        icon: Icon(Icons.add, color: Colors.black),
        onPressed: onAdd,
      );
    } else if (onDelete != null) {
      trailingWidget = IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      );
    }

    return Card(
      color: backgroundColor,
      child: ListTile(
        title: Text(
          service.name,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          subtitle ?? 'RM ${service.price.toStringAsFixed(2)}',
          style: TextStyle(color: Colors.black87),
        ),
        trailing: trailingWidget,
      ),
    );
  }
}
