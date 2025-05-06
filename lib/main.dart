import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(XrayApp());
}

class XrayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X-ray App',
      home: XrayHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class XrayHomePage extends StatefulWidget {
  @override
  _XrayHomePageState createState() => _XrayHomePageState();
}

class _XrayHomePageState extends State<XrayHomePage> {
  File? _image;
  String _result = '';

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = "Detecting...";
      });

      // Simulated API call result
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _result = "Diagnosis: Pneumonia";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('X-ray Diagnosis')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image != null
                ? Image.file(_image!, height: 200)
                : Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(child: Text("No image selected")),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select X-ray Image'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
