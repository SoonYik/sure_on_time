import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item_info_page.dart';
import 'item_provider.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Scheduled Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.search, size: 30),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    //controller: null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Search part',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Sort by:'),
                SizedBox(width: 20),
                ElevatedButton(
                    onPressed: null, child: Text('Address Name')),
                SizedBox(width: 20),
                ElevatedButton(
                    onPressed: null, child: Text('Date')),
                SizedBox(width: 20),
                ElevatedButton(
                    onPressed: null, child: Text('Priority')),
              ],
            ),
            ListView.separated(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final item = context.watch<ItemProvider>().itemList[index];
                  return ListTile(
                    leading: Icon(Icons.inventory, size: 30),
                    title: Text(item.id.toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Destination: ${item.destination}'),
                        Text('Required by: ${item.dateReq}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ItemInfoPage(item: item),
                        ),
                      );
                    },
                  );
                },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemCount: context.watch<ItemProvider>().itemList.length,
            )
          ],
        ),
      ),
    );
  }
}
