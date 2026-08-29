import 'package:flutter/material.dart';
import '../models/alert.dart';
import '../services/notification_service.dart';

// This screen lets the user type in a new alert.
// When they tap "Save", we send the new Alert back to the Home screen.
class AddAlertScreen extends StatefulWidget {
  const AddAlertScreen({super.key});

  @override
  State<AddAlertScreen> createState() => _AddAlertScreenState();
}

class _AddAlertScreenState extends State<AddAlertScreen> {
  // Controllers let us read whatever the user types in the text fields.
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void _saveAlert() async {
    // Basic beginner-level validation: don't save if title is empty.
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    final newAlert = Alert(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      date: _dateController.text.trim().isEmpty
          ? 'No date set'
          : _dateController.text.trim(),
    );

    // Show a simple notification about the new alert.
    // This is wrapped safely inside NotificationService, so even if it
    // fails (e.g. permission not granted), saving the alert still works.
    await NotificationService.showNotification(
      'New Alert: ${newAlert.title}',
      newAlert.description.isEmpty ? 'A new alert was posted.' : newAlert.description,
    );

    if (!mounted) return;

    // Send the new alert back to the Home screen.
    Navigator.pop(context, newAlert);
  }

  @override
  void dispose() {
    // Always dispose controllers to avoid memory leaks.
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Alert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Date (e.g. 05 Sep 2026)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveAlert,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Save Alert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
