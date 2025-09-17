import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'item.dart';
import 'item_provider.dart';

final TextEditingController idCtrl = TextEditingController();
final TextEditingController quantityCtrl = TextEditingController();
final TextEditingController destinationCtrl = TextEditingController();
final TextEditingController dateReqCtrl = TextEditingController();
final _formKey = GlobalKey<FormState>();

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String selectedValue = 'Normal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Delivery Page'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                 children: [
                   const Text('Part ID: ', style: TextStyle(fontWeight: FontWeight.bold)),
                   const SizedBox(width: 20),
                   Expanded(
                     child: TextFormField(
                       controller: idCtrl,
                       keyboardType: TextInputType.number,
                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                       decoration: const InputDecoration(
                         labelText: 'Enter Part ID (eg. 1001)',
                       ),
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter an integer.';
                         }
                         final intValue = int.tryParse(value);
                         if (intValue == null) {
                           return 'Invalid number.';
                         }
                         if (intValue <= 0) {
                           return 'Part ID must be greater than 0.';
                         }
                         final itemProvider = context.read<ItemProvider>();
                         final isDuplicate = itemProvider.itemList.any((item) => item.id == intValue);
                         if (isDuplicate) {
                           return 'This Part ID already exists!';
                         }
                         return null;
                       },
                     ),
                   ),
                 ],
              ),
              Row(
                  children: [
                    const Text('Quantity: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: quantityCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          labelText: 'Enter Quantity',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an integer.';
                          }
                          final qty = int.parse(value);
                          if (qty == null) {
                            return 'Invalid number.';
                          }
                          if (qty <= 0) {
                            return 'Quantity must be greater than 0.';
                          }return null;
                        },
                      ),
                    ),
                  ],
                ),
              Row(
                  children: [
                    const Text('Destination: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: destinationCtrl,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Enter Destination Address',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a destination.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              Row(
                  children: [
                    const Text('Required by: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: dateReqCtrl,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Select Date',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date.';
                          }
                          return null;
                        },
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2026),
                          );
                          if (pickedDate != null) {
                            dateReqCtrl.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              Row(
                  children: [
                    const Text('Priority: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 20),
                    DropdownButton<String>(
                      value: selectedValue,
                      items: ['Normal', 'Urgent']
                          .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      )).toList(), onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ElevatedButton(onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newItem = Item(
                    int.parse(idCtrl.text),
                    int.parse(quantityCtrl.text),
                    destinationCtrl.text,
                    DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    dateReqCtrl.text,
                    selectedValue,
                  );
                  context.read<ItemProvider>().add(newItem);
                  idCtrl.clear();
                  quantityCtrl.clear();
                  destinationCtrl.clear();
                  dateReqCtrl.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Delivery Added Successfully!')),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please complete all the details.'),
                    ),
                  );
                }
              },
                child: const Text('Add Delivery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
