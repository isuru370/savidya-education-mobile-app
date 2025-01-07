import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.tealColor[10], // Match app theme color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon to indicate "Access Denied"
              Icon(
                Icons.block,
                color: ColorUtil.roseColor[10],
                size: 100,
              ),
              const SizedBox(height: 20),

              // Error title
              const Text(
                'Access Denied',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Message with instructions
              Text(
                "Sorry, you don't have permission to view this page.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // "Return to Home" button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  backgroundColor:
                      ColorUtil.whiteColor[14], // Matching app colors
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/home'); // Navigate to the home page
                },
                child: Text(
                  'Return to Home',
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorUtil.tealColor[10], // Match app's primary color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
