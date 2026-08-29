import 'package:flutter/material.dart';
import '../models/alert.dart';

// This screen shows the full details of a single alert.
// It also has a delete button so the user can remove this alert
// straight from the detail view.
class DetailScreen extends StatelessWidget {
  final Alert alert;

  const DetailScreen({super.key, required this.alert});

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Alert'),
          content: Text('Are you sure you want to delete "${alert.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // just closes dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close the dialog
                // Send 'delete' back to Home screen so it knows to remove this alert.
                Navigator.pop(context, 'delete');
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alert.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(alert.date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(height: 30),
            Text(
              alert.description.isEmpty ? 'No description added.' : alert.description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
