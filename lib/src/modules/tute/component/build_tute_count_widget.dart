import 'package:flutter/material.dart';

class BuildTuteCountWidget extends StatelessWidget {
  final int paymentCount;
  final int tuteCount;
  
  const BuildTuteCountWidget({
    super.key,
    required this.paymentCount,
    required this.tuteCount,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = paymentCount > 0;
    final hasTute = tuteCount > 0;
    
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Payment Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPaid ? Icons.check_circle : Icons.pending,
                  color: isPaid ? Colors.green : Colors.orange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  isPaid ? 'Payment Received' : 'Payment Pending',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isPaid ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Tute Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasTute ? Icons.book : Icons.book_outlined,
                  color: hasTute ? Colors.blue : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  hasTute ? 'Tute Issued' : 'Tute Not Issued',
                  style: TextStyle(
                    fontSize: 14,
                    color: hasTute ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}