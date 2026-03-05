import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/features/recipe_scanner/widgets/cuisine_selector.dart';
import 'package:recipe_app/services/ai_service.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String selectedCuisine = "Asian";
  File? _image;
  final _picker = ImagePicker();

  Future<void> _getImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showResultsSheet(String jsonResult) {
    List<dynamic> recipes = [];
    try {
      // Clean the string in case Gemini added markdown backticks
      String cleanJson = jsonResult.replaceAll('```json', '').replaceAll('```', '').trim();
      recipes = jsonDecode(cleanJson);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("AI returned invalid data. Please try again.")),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Suggested $selectedCuisine Recipes",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 2,
                      child: ExpansionTile(
                        leading: const Icon(Icons.restaurant_menu, color: Colors.orange),
                        title: Text(
                          recipe['name'] ?? "Unknown Recipe",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("${(recipe['ingredients'] as List).length} ingredients"),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("🛒 Ingredients:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                                const SizedBox(height: 5),
                                ...((recipe['ingredients'] as List).map((ing) => Text("• $ing"))),
                                const SizedBox(height: 15),
                                const Text("👨‍🍳 Instructions:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                                const SizedBox(height: 5),
                                ...((recipe['instructions'] as List).asMap().entries.map((step) => 
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text("${step.key + 1}. ${step.value}"),
                                  )
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Recipe Scanner")),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              icon: const Icon(Icons.auto_awesome),
              label: const Text("Scan & Suggest", style: TextStyle(fontSize: 16)),
              onPressed: _image == null
                  ? null
                  : () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.orange)),
                      );

                      final result = await AIService.getRecipeSuggestions(_image!, selectedCuisine);

                      if (!mounted) return;
                      Navigator.pop(context); // Close loading dialog

                      if (result != null) {
                        _showResultsSheet(result);
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}