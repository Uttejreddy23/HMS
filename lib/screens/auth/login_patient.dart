// login_patient.dart
import 'package:flutter/material.dart';
import '../dashboards/patient_dashboard.dart';

class PatientLoginPage extends StatelessWidget {
  const PatientLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Patient Login")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: integrate with backend later
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PatientDashboard()));
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
