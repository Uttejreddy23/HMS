import 'package:flutter/material.dart';
import '../auth/universal_login.dart';
import '../auth/universal_register.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollNotifier.value = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "SmartKare 🏥",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ValueListenableBuilder<double>(
        valueListenable: _scrollNotifier,
        builder: (context, scrollOffset, _) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                _AnimatedSection(
                  visible: scrollOffset < 100,
                  child: Container(
                    height: size.height * 0.85,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Welcome to SmartKare",
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "Futuristic hospital management for AI diagnostics, holographic telemedicine, and quantum healthcare.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const UniversalLoginPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text("Login",
                                  style: TextStyle(fontSize: 18)),
                            ),
                            const SizedBox(width: 20),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const UniversalRegisterPage()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text("Register",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // About Section
                _AnimatedSection(
                  visible: scrollOffset > 100,
                  child: _SectionContainer(
                    color: Colors.white,
                    title: "About SmartKare",
                    content:
                        "SmartKare is a next-generation digital healthcare ecosystem powered by AI, Blockchain, and Robotics. "
                        "We transform patient experiences through smart OP booking, real-time telemedicine, and AI-driven diagnosis.",
                  ),
                ),

                // Features Section
                _AnimatedSection(
                  visible: scrollOffset > 300,
                  child: Container(
                    color: const Color(0xFFF4F8FB),
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: const [
                        SectionTitle(title: "Key Features"),
                        SizedBox(height: 20),
                        FeatureGrid(),
                      ],
                    ),
                  ),
                ),

                // Services Section
                _AnimatedSection(
                  visible: scrollOffset > 600,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: const [
                        SectionTitle(title: "Our Services"),
                        SizedBox(height: 20),
                        ServicesSection(),
                      ],
                    ),
                  ),
                ),

                // Smart AI Section
                _AnimatedSection(
                  visible: scrollOffset > 900,
                  child: Container(
                    color: const Color(0xFF1976D2),
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: const [
                        Text(
                          "AI-Powered Smart Diagnosis 🧠",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "SmartKare uses advanced AI to analyze patient symptoms and suggest doctors instantly. "
                          "It predicts health risks using quantum computing insights and personalized analytics.",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                // Contact Section
                _AnimatedSection(
                  visible: scrollOffset > 1200,
                  child: _SectionContainer(
                    color: Colors.white,
                    title: "Contact Us",
                    content:
                        "📧 support@smartkare.com\n📞 +91 98765 43210\n🏢 Hyderabad, Andhra Pradesh, India",
                  ),
                ),

                // Footer
                Container(
                  color: const Color(0xFF0D47A1),
                  padding: const EdgeInsets.all(20),
                  child: const Center(
                    child: Text(
                      "© 2025 SmartKare | Designed by Teja Kotcherla",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ------------------------------------------------------------
// 🔹 Reusable Widgets Below
// ------------------------------------------------------------

class _AnimatedSection extends StatelessWidget {
  final Widget child;
  final bool visible;
  const _AnimatedSection({required this.child, required this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: visible ? Offset.zero : const Offset(0, 0.2),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 600),
        child: child,
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  const _SectionContainer(
      {required this.title, required this.content, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          SectionTitle(title: title),
          const SizedBox(height: 10),
          Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }
}

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {"icon": Icons.calendar_month, "title": "Online OP Booking"},
      {"icon": Icons.local_hospital_rounded, "title": "Hospital Management"},
      {"icon": Icons.video_call_rounded, "title": "Telemedicine"},
      {"icon": Icons.shield_rounded, "title": "Blockchain Security"},
      {"icon": Icons.science_rounded, "title": "AI Diagnosis"},
      {"icon": Icons.analytics_rounded, "title": "Predictive Analytics"},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: features
          .map((f) => Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(f["icon"] as IconData,
                          size: 40, color: Colors.blueAccent),
                      const SizedBox(height: 10),
                      Text(f["title"] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      "Virtual Consultations",
      "Smart Appointment Scheduling",
      "Electronic Health Records",
      "Pharmacy Management",
      "Emergency Assistance",
      "Robotic Surgeries",
    ];

    return Column(
      children: services
          .map((service) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.blueAccent),
                    const SizedBox(width: 10),
                    Text(service,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87)),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
