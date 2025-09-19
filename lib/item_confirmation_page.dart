import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';

class ConfirmationPage extends StatefulWidget {
  final Item item;
  const ConfirmationPage({super.key, required this.item});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  File? _image;
  final ImagePicker picker = ImagePicker();
  final TextEditingController nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImagePath = prefs.getString('saved_image_${widget.item.id}');
    final savedName = prefs.getString('saved_name_${widget.item.id}');
    if (savedImagePath != null && File(savedImagePath).existsSync()) {
      setState(() {
        _image = File(savedImagePath);
      });
    }
    if (savedName != null) {
      setState(() {
        nameCtrl.text = savedName;
      });
    }
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final String newPath = '${directory.path}/${widget.item.id}_${DateTime.now().millisecondsSinceEpoch}.png';
      final File savedImage = await File(pickedFile.path).copy(newPath);

      setState(() {
        _image = savedImage;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected.')),
      );
    }
  }

  Future<void> saveData() async {
    final name = nameCtrl.text.trim();
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
      return;
    }

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a personnel name.')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_image_${widget.item.id}', _image!.path);
    await prefs.setString('saved_name_${widget.item.id}', name);
    setState(() {
      widget.item.status = 'Delivered';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data saved successfully!')),
    );
    Navigator.pop(context, widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Take a photo with the delivered package:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: _image == null
                  ? const Text('No image selected.')
                  : Image.file(
                _image!,
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: getImage,
                child: const Text('Pick Image from Gallery'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter personnel name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: nameCtrl,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Personnel Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: saveData,
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: 20),
            if (widget.item.status == 'Delivered')
              Center(
                child: Text(
                  'Status: Delivered',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
