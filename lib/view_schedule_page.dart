import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item_info_page.dart';
import 'item_provider.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  String searchQuery = '';
  String sortBy = '';

  @override
  Widget build(BuildContext context) {
    final itemProvider = context.watch<ItemProvider>();

    var filteredList = itemProvider.itemList.where((item) {
      return item.destination.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.id.toString().contains(searchQuery);
    }).toList();

    if (sortBy == 'address') {
      filteredList.sort((a, b) => a.destination.compareTo(b.destination));
    } else if (sortBy == 'date') {
      filteredList.sort((a, b) => a.dateReq.compareTo(b.dateReq));
    } else if (sortBy == 'priority') {
      filteredList.sort((a, b){
        if (a.priority == 'Urgent' && b.priority == 'Normal') return -1;
        if (a.priority == 'Normal' && b.priority == 'Urgent') return 1;
        return 0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Scheduled Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.search, size: 30),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search by Part ID or Destination',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Sort by:'),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      sortBy = 'address';
                    });
                  },
                  child: const Text('Address Name'),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      sortBy = 'date';
                    });
                  },
                  child: const Text('Date'),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      sortBy = 'priority';
                    });
                  },
                  child: const Text('Priority'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    final item = filteredList[index];
                    return ListTile(
                      leading: const Icon(Icons.inventory, size: 30),
                      title: Text('Part ID: ${item.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Destination: ${item.destination}'),
                          Text('Required by: ${item.dateReq}'),
                          Text('Priority: ${item.priority}'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemInfoPage(item: item),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                  itemCount: filteredList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
