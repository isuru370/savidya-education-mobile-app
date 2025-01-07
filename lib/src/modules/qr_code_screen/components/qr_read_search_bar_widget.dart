import 'package:flutter/material.dart';

class QrReadSearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch; // Function to handle search
  const QrReadSearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search by Student ID',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
            contentPadding: const EdgeInsets.all(16),
          ),
          onSubmitted: (value) => onSearch(value.trim()), // Call onSearch when submitted
        ),
        const SizedBox(height: 10), // Add spacing between the text field and button
        ElevatedButton(
          onPressed: () => onSearch(controller.text.trim()), // Call onSearch when button is pressed
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text('Search'),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
