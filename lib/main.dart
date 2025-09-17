import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'add_delivery_page.dart';
import 'item_provider.dart';
import 'view_schedule_page.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => ItemProvider(),
        child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Sure! OnTime'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sure!', style: Theme.of(context).textTheme.displaySmall,),
            Text('OnTime', style: Theme.of(context).textTheme.displaySmall,),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewPage())
                );
              },
              child: Text('View Schedule'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPage())
                );
              },
              child: Text('Add New Delivery'),
            ),
            SizedBox(height: 10),
            Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.timestamp())),
          ],
        ),
      ),
    );
  }
}
