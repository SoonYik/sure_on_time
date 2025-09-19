import 'dart:io';

import 'package:flutter/material.dart';
import 'item.dart';
import 'item_confirmation_page.dart';

class ItemInfoPage extends StatefulWidget {
  final Item item;
  const ItemInfoPage({super.key, required this.item});
  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.inventory, size: 70),
            Text('Part ID: ${widget.item.id}'),
            const SizedBox(height: 8),
            Text('Quantity: ${widget.item.quantity}'),
            const SizedBox(height: 8),
            Text('Destination: ${widget.item.destination}'),
            const SizedBox(height: 8),
            Text('Ordered on: ${widget.item.dateOrder}'),
            const SizedBox(height: 8),
            Text('Required by: ${widget.item.dateReq}'),
            const SizedBox(height: 8),
            Text('Priority: ${widget.item.priority}'),
            const SizedBox(height: 8),
            Text('Status: ${widget.item.status}'),
            const SizedBox(height: 20),
            if (item.image != null)
              Column(
                children: [
                  Image.file(
                    File(item.image!),
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text('Confirmed by: ${item.name ?? "Unknown"}'),
                ],
              ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(item: item),
                  ),
                );
                setState(() {});
              },
              child: Text('Confirm Delivery'),
            ),
          ],

        ),
      ),
    );
  }
}

