import 'package:flutter/material.dart';

/// ============================================================
/// STATELESS vs STATEFUL WIDGETS DEMO
/// ============================================================
/// This screen demonstrates the fundamental difference between
/// Stateless and Stateful widgets in Flutter.
///
/// - StatelessWidget: Does not store mutable state. Once built,
///   it remains unchanged until rebuilt by its parent.
///
/// - StatefulWidget: Maintains internal state that can change
///   during the app's lifecycle, triggering UI rebuilds.
/// ============================================================

// ===== STATELESS WIDGETS =====

/// A simple StatelessWidget that displays a greeting.
/// It never changes by itself - only when parent rebuilds it with new data.
class GreetingWidget extends StatelessWidget {
  final String name;

  const GreetingWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, $name! 👋',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }
}

/// A StatelessWidget that displays a static header banner.
/// This content never changes - perfect use case for StatelessWidget.
class StaticHeaderBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const StaticHeaderBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade700, Colors.green.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// A StatelessWidget info card that displays static information.
class StaticInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const StaticInfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===== STATEFUL WIDGETS =====

/// A StatefulWidget that maintains a counter state.
/// The UI updates dynamically when the counter changes via setState().
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '🔢 Counter (Stateful)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap buttons to change the count',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),
          Text(
            '$_count',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: _count >= 0 ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _decrement,
                icon: const Icon(Icons.remove),
                label: const Text('Decrease'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _increment,
                icon: const Icon(Icons.add),
                label: const Text('Increase'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: _reset,
            icon: const Icon(Icons.refresh),
            label: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

/// A StatefulWidget that toggles between Light and Dark themes.
class ThemeToggleWidget extends StatefulWidget {
  const ThemeToggleWidget({super.key});

  @override
  State<ThemeToggleWidget> createState() => _ThemeToggleWidgetState();
}

class _ThemeToggleWidgetState extends State<ThemeToggleWidget> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (_isDarkMode ? Colors.black : Colors.green).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            _isDarkMode ? Icons.dark_mode : Icons.light_mode,
            size: 50,
            color: _isDarkMode ? Colors.amber : Colors.orange,
          ),
          const SizedBox(height: 12),
          Text(
            _isDarkMode ? '🌙 Dark Mode' : '☀️ Light Mode',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toggle to switch themes',
            style: TextStyle(
              fontSize: 14,
              color: _isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          Switch(
            value: _isDarkMode,
            onChanged: (value) => _toggleTheme(),
            activeColor: Colors.amber,
            inactiveThumbColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}

/// A StatefulWidget that changes color on tap.
class ColorChangerWidget extends StatefulWidget {
  const ColorChangerWidget({super.key});

  @override
  State<ColorChangerWidget> createState() => _ColorChangerWidgetState();
}

class _ColorChangerWidgetState extends State<ColorChangerWidget> {
  final List<Color> _colors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
  ];
  int _currentIndex = 0;

  void _changeColor() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _colors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _colors[_currentIndex].withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '🎨 Color Changer (Stateful)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _changeColor,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: _colors[_currentIndex],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _colors[_currentIndex].withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.touch_app,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tap the circle to change color!',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

// ===== MAIN DEMO SCREEN =====

/// The main demo screen combining both Stateless and Stateful widgets.
class StatelessStatefulDemoScreen extends StatelessWidget {
  const StatelessStatefulDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STATELESS: Static header banner (never changes)
            const StaticHeaderBanner(
              title: 'Stateless vs Stateful',
              subtitle: 'Understanding Flutter Widget Types',
              icon: Icons.widgets,
            ),

            const SizedBox(height: 24),

            // Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '📦 Stateless Widgets',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'These widgets display static content that never changes by itself.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ),

            const SizedBox(height: 12),

            // STATELESS: Greeting widget
            const Center(child: GreetingWidget(name: 'GreenGuide User')),

            const SizedBox(height: 12),

            // STATELESS: Info cards
            const StaticInfoCard(
              title: 'StatelessWidget',
              description: 'Does not store mutable state. Perfect for static UI elements like labels, icons, and text.',
              icon: Icons.lock,
              color: Colors.blue,
            ),
            const StaticInfoCard(
              title: 'Immutable',
              description: 'Once built, it remains unchanged until the parent widget rebuilds it with new data.',
              icon: Icons.shield,
              color: Colors.purple,
            ),

            const SizedBox(height: 32),

            // Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '⚡ Stateful Widgets',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'These widgets maintain internal state and update dynamically.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ),

            const SizedBox(height: 16),

            // STATEFUL: Counter widget
            const CounterWidget(),

            const SizedBox(height: 16),

            // STATEFUL: Theme toggle widget
            const ThemeToggleWidget(),

            const SizedBox(height: 16),

            // STATEFUL: Color changer widget
            const ColorChangerWidget(),

            const SizedBox(height: 32),

            // Key Takeaways Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.green.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'Key Takeaways',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTakeawayItem('StatelessWidget is for display-only UI that never changes.'),
                  _buildTakeawayItem('StatefulWidget is for interactive UI that changes over time.'),
                  _buildTakeawayItem('Use setState() to trigger UI rebuilds in StatefulWidget.'),
                  _buildTakeawayItem('Only the widgets that change get rebuilt, not the entire tree.'),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTakeawayItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
