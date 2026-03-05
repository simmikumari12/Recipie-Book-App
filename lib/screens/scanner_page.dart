import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// Corrected Import Path
import 'package:recipe_app/features/recipe_scanner/widgets/cuisine_selector.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String selectedCuisine = "Asian"; 
  File? _image; // To store the captured photo
  final _picker = ImagePicker();

  // Function to open camera
  Future<void> _getImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Recipe Scanner")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Replaced Placeholder with Image Display logic
            GestureDetector(
              onTap: _getImage,
              child: Container(
                height: 300,
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: _image == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                          Text("Tap to scan ingredients"),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),

            CuisineSelector(
              onCuisineChanged: (val) {
                setState(() => selectedCuisine = val);
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: _image == null 
                ? null // Disable button if no image is scanned
                : () {
                    print("AI prompt: Find $selectedCuisine recipes for this image");
                  }, 
              child: const Text("Scan & Suggest"),
            ),
          ],
        ),
      ),
    );
  }
}