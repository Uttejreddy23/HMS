import 'package:flutter/material.dart';
import '../auth/universal_login.dart';
import '../auth/universal_register.dart';
import '../appointments/appointment_page.dart';

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
                // 🌟 HERO SECTION (Animated Parallax)
                _AnimatedSection(
                  visible: scrollOffset < 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(0, scrollOffset * 0.2),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.9,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Welcome to SmartKare",
                              style: TextStyle(
                                fontSize: 42,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                "AI-powered hospital management, robotic healthcare, and holographic telemedicine for the future of digital health.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Wrap(
                              spacing: 20,
                              children: [
                                _HoverButton(
                                  label: "Login",
                                  color: Colors.white,
                                  textColor: Colors.blueAccent,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const UniversalLoginPage()),
                                  ),
                                ),
                                _HoverButton(
                                  label: "Register",
                                  outlined: true,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const UniversalRegisterPage()),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const _GradientDivider(),

                // 🔹 ABOUT SECTION
                _SectionContainer(
                  color: Colors.white,
                  title: "About SmartKare",
                  content:
                      "SmartKare is an intelligent healthcare ecosystem integrating AI diagnostics, blockchain transparency, and robotic operations to redefine patient care for the digital future.",
                ),

                const _GradientDivider(),

                // 🔹 FEATURE GRID (Animated)
                const _AnimatedFeatureGrid(),

                // 🔹 LIVE STATS (Animated Counters)
                _AnimatedSection(
                  visible: scrollOffset > 400,
                  child: const _AnimatedStatsSection(),
                ),

                const _GradientDivider(),

                // 🔹 BOOK APPOINTMENT (Animated)
                _BookAppointmentSection(scrollOffset: scrollOffset),

                // 🔹 AI SYMPTOM CHECKER
                _SectionContainer(
                  color: const Color(0xFF1976D2),
                  title: "AI Symptom Checker 🤖",
                  content:
                      "Describe your symptoms and let our AI suggest the right specialist in seconds. Experience Smart Diagnosis — the future of medical triage.",
                  textColor: Colors.white,
                ),

                // 🔹 TESTIMONIALS
                _AnimatedSection(
                  visible: scrollOffset > 900,
                  child: const _TestimonialsSection(),
                ),

                // 🔹 CONTACT SECTION
                _SectionContainer(
                  color: Colors.white,
                  title: "Contact Us",
                  content:
                      "📧 support@smartkare.com\n📞 +91 98765 43210\n🏢 Hyderabad, Andhra Pradesh, India",
                ),

                // 🔹 FOOTER
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

//
// 🌈 Reusable Widgets
//

class _HoverButton extends StatefulWidget {
  final String label;
  final Color color;
  final Color textColor;
  final bool outlined;
  final VoidCallback onTap;

  const _HoverButton({
    required this.label,
    this.color = Colors.blueAccent,
    this.textColor = Colors.white,
    this.outlined = false,
    required this.onTap,
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: _hovering ? 1.05 : 1.0,
        child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                widget.outlined ? Colors.transparent : widget.color,
            foregroundColor: widget.textColor,
            side: widget.outlined
                ? const BorderSide(color: Colors.white)
                : BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(widget.label, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

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

class _GradientDivider extends StatelessWidget {
  const _GradientDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlue, Colors.cyan],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}

//
// 🔹 BOOK APPOINTMENT SECTION (Upgraded)
//
class _BookAppointmentSection extends StatelessWidget {
  final double scrollOffset;
  const _BookAppointmentSection({required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return _AnimatedSection(
      visible: scrollOffset > 600,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          children: [
            const SectionTitle(title: "Book an Appointment 🗓️"),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Instantly connect with doctors for online or in-person consultations — powered by SmartKare’s AI scheduling system.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.9, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AppointmentPage()),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text(
                  "Book Appointment",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  shadowColor: Colors.blueAccent.withOpacity(0.4),
                  elevation: 10,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "It only takes a minute to schedule your consultation.",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

//
// 🔹 FEATURE GRID (Animated Staggered Entry)
//
class _AnimatedFeatureGrid extends StatelessWidget {
  const _AnimatedFeatureGrid();

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

    return Container(
      color: const Color(0xFFF4F8FB),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const SectionTitle(title: "Key Features ⚙️"),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final f = features[index];
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 400 + (index * 100)),
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.8 + (0.2 * value),
                    child: child,
                  ),
                ),
                child: Card(
                  elevation: 4,
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//
// 🔹 Animated Stats Section (with number animation)
//
class _AnimatedStatsSection extends StatelessWidget {
  const _AnimatedStatsSection();

  @override
  Widget build(BuildContext context) {
    final stats = [
      {"icon": Icons.people, "label": "Patients Served", "count": 25000},
      {
        "icon": Icons.medical_services,
        "label": "Doctors Available",
        "count": 1200
      },
      {
        "icon": Icons.health_and_safety,
        "label": "Successful Consults",
        "count": 18000
      },
    ];

    return Container(
      color: const Color(0xFFE3F2FD),
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.map((s) {
          return Column(
            children: [
              Icon(s["icon"] as IconData, size: 40, color: Colors.blueAccent),
              const SizedBox(height: 10),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: s["count"] as int),
                duration: const Duration(seconds: 2),
                builder: (context, value, _) => Text(
                  "$value+",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Text(s["label"] as String,
                  style: const TextStyle(color: Colors.black54, fontSize: 14)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

//
// 🔹 Testimonials Section (same as before)
//
class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();

  @override
  Widget build(BuildContext context) {
    final testimonials = const [
      {
        "quote":
            "SmartKare helped me connect with a specialist in minutes. The AI symptom checker is amazing!",
        "author": "Aarav, Patient"
      },
      {
        "quote":
            "Managing hospital operations is now effortless with SmartKare’s blockchain and AI features.",
        "author": "Dr. Meera, Cardiologist"
      },
      {
        "quote":
            "The virtual consultations are smooth and reliable. Highly recommended platform!",
        "author": "Rohit, Patient"
      },
    ];

    return Container(
      color: const Color(0xFFF4F8FB),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const SectionTitle(title: "What Our Users Say 💬"),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.9),
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                final t = testimonials[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "\"${t['quote']}\"",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 10),
                        Text("- ${t['author']}",
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  final Color textColor;
  final Widget? child;

  const _SectionContainer({
    required this.title,
    required this.content,
    required this.color,
    this.textColor = Colors.black87,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          SectionTitle(title: title, color: textColor),
          const SizedBox(height: 10),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
          if (child != null) ...[
            const SizedBox(height: 20),
            child!,
          ]
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final Color color;
  const SectionTitle(
      {super.key, required this.title, this.color = Colors.black87});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
    );
  }
}
