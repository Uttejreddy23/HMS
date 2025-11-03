// landing_page.dart
import 'package:flutter/material.dart';
import '../auth/login_patient.dart';
import '../auth/login_doctor.dart';
import '../auth/login_admin.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartKare'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to SmartKare', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PatientLoginPage())),
              child: const Text('Patient Login'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorLoginPage())),
              child: const Text('Doctor Login'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLoginPage())),
              child: const Text('Admin Login'),
            ),
          ],
        ),
      ),
    );
  }
}
