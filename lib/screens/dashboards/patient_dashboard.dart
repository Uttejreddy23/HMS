// patient_dashboard.dart
import 'package:flutter/material.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patient Dashboard")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text("Welcome, Patient!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              title: const Text("Book Appointment"),
              subtitle: const Text("Schedule a new consultation"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("View Reports"),
              subtitle: const Text("Access medical records"),
              trailing: const Icon(Icons.description),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
