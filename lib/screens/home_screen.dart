import 'package:flutter/material.dart';
import '../models/alert.dart';
import 'add_alert_screen.dart';
import 'detail_screen.dart';

// This is the main/home screen of the app.
// It keeps the list of alerts in memory (a simple List<Alert>)
// and shows them using a ListView.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This list holds all the alerts. Starting with a couple of
  // sample alerts so the app doesn't look empty when it first opens.
  final List<Alert> _alerts = [
    Alert(
      title: 'Mid-Sem Exams Begin',
      description: 'Mid-semester exams start next Monday. Check your timetable on the notice board.',
      date: '05 Sep 2026',
    ),
    Alert(
      title: 'Annual Cultural Fest',
      description: 'Get ready for 3 days of music, dance and fun at the college fest!',
      date: '12 Sep 2026',
    ),
  ];

  // Opens the Add Alert screen and waits for a new Alert to come back.
  void _goToAddAlertScreen() async {
    final newAlert = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddAlertScreen()),
    );

    // If the user actually filled the form and saved, we get an Alert back.
    if (newAlert != null && newAlert is Alert) {
      setState(() {
        _alerts.add(newAlert);
      });
    }
  }

  // Opens the Detail screen for one alert. If the user deletes it there,
  // we remove it from our list here.
  void _goToDetailScreen(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(alert: _alerts[index]),
      ),
    );

    if (result == 'delete') {
      setState(() {
        _alerts.removeAt(index);
      });
    }
  }

  // Deletes an alert directly from the home screen list.
  void _deleteAlert(int index) {
    setState(() {
      _alerts.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alert deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('College Alert'),
      ),
      body: _alerts.isEmpty
          ? const Center(
              child: Text(
                'No alerts yet.\nTap the + button to add one!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _alerts.length,
              itemBuilder: (context, index) {
                final alert = _alerts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(
                      alert.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(alert.date),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteAlert(index),
                    ),
                    onTap: () => _goToDetailScreen(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddAlertScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
