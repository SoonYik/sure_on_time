import 'package:flutter/material.dart';
import 'item.dart';
import 'item_confirmation_page.dart';

class ItemInfoPage extends StatelessWidget {
  final Item item;
  const ItemInfoPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
            Text('Part ID: ${item.id}'),
            const SizedBox(height: 8),
            Text('Quantity: ${item.quantity}'),
            const SizedBox(height: 8),
            Text('Destination: ${item.destination}'),
            const SizedBox(height: 8),
            Text('Ordered on: ${item.dateOrder}'),
            const SizedBox(height: 8),
            Text('Required by: ${item.dateReq}'),
            const SizedBox(height: 8),
            Text('Priority: ${item.priority}'),
            const SizedBox(height: 8),
            Text('Status: En Route'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConfirmationPage(title: '',))
                );
              },
              child: Text('Confirm Delivery'),
            ),
          ],

        ),
      ),
    );
  }
}

