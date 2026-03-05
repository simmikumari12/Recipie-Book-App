import 'package:flutter/material.dart';


class CuisineSelector extends StatefulWidget {
  final Function(String) onCuisineChanged;

  const CuisineSelector({super.key, required this.onCuisineChanged});

  @override
  State<CuisineSelector> createState() => _CuisineSelectorState();
}

class _CuisineSelectorState extends State<CuisineSelector> {
  // List of available cuisines with their corresponding icons
  final List<Map<String, dynamic>> _cuisines = [
    {'label': 'Asian', 'icon': '🍜'},
    {'label': 'French', 'icon': '🥐'},
    {'label': 'American', 'icon': '🍔'},
    {'label': 'Mexican', 'icon': '🌮'},
    {'label': 'Italian', 'icon': '🍝'},
  ];

  String _selectedCuisine = 'Asian'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Select Your Vibe",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: _cuisines.length,
            itemBuilder: (context, index) {
              final item = _cuisines[index];
              final isSelected = _selectedCuisine == item['label'];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text("${item['icon']} ${item['label']}"),
                  selected: isSelected,
                  selectedColor: Colors.orange.shade100,
                  checkmarkColor: Colors.orange,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.orange.shade900 : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCuisine = item['label'];
                    });
                    widget.onCuisineChanged(_selectedCuisine);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}