import 'package:flutter/material.dart';

/// Widget Tree & Reactive UI Model Demo
/// This screen demonstrates:
/// 1. Nested widget hierarchy
/// 2. State management with setState()
/// 3. Reactive UI updates when state changes
class WidgetTreeDemoScreen extends StatefulWidget {
  const WidgetTreeDemoScreen({super.key});

  @override
  State<WidgetTreeDemoScreen> createState() => _WidgetTreeDemoScreenState();
}

class _WidgetTreeDemoScreenState extends State<WidgetTreeDemoScreen> {
  // State variables that trigger reactive updates
  int _counterValue = 0;
  bool _isCardExpanded = false;
  Color _backgroundColor = Colors.green;
  
  // Methods to update state
  void _incrementCounter() {
    setState(() {
      _counterValue++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counterValue--;
    });
  }

  void _toggleCardExpansion() {
    setState(() {
      _isCardExpanded = !_isCardExpanded;
    });
  }

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = _backgroundColor == Colors.green
          ? Colors.blue
          : Colors.green;
    });
  }

  void _resetCounter() {
    setState(() {
      _counterValue = 0;
      _isCardExpanded = false;
      _backgroundColor = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Root widget - Scaffold
    return Scaffold(
      // AppBar widget
      appBar: AppBar(
        title: const Text('Widget Tree & Reactive UI Demo'),
        elevation: 0,
        backgroundColor: _backgroundColor,
      ),
      
      // Body - Center widget
      body: Container(
        color: _backgroundColor.withOpacity(0.1),
        child: Center(
          // Main Column - arranges children vertically
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header Section
                _buildHeaderSection(),
                
                const SizedBox(height: 30),
                
                // Counter Card Section
                _buildCounterCard(),
                
                const SizedBox(height: 30),
                
                // Expandable Info Card Section
                _buildInfoCard(),
                
                const SizedBox(height: 30),
                
                // Action Buttons Section
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget building helper methods to keep the tree organized

  /// Header section with title and description
  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        children: [
          Text(
            'Widget Tree Hierarchy',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Tap buttons below to see how Flutter\'s reactive model rebuilds only affected widgets',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  /// Counter display and interaction card
  Widget _buildCounterCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Counter Example',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Count display
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              decoration: BoxDecoration(
                color: _backgroundColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _backgroundColor, width: 2),
              ),
              child: Text(
                'Count: $_counterValue',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: _backgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Button row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _decrementCounter,
                  icon: const Icon(Icons.remove),
                  label: const Text('Decrease'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _incrementCounter,
                  icon: const Icon(Icons.add),
                  label: const Text('Increase'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Expandable information card
  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _toggleCardExpansion,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'About Widget Trees',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    _isCardExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                  ),
                ],
              ),
            ),
            
            if (_isCardExpanded) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'A widget tree is a hierarchical representation of all widgets in your app. '
                  'When state changes, Flutter rebuilds only the affected widgets, making UIs efficient and responsive. '
                  'This demonstrates the reactive model!',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Action buttons section
  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _changeBackgroundColor,
              icon: const Icon(Icons.palette),
              label: const Text('Toggle Theme'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _backgroundColor == Colors.green
                    ? Colors.green
                    : Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: _resetCounter,
          icon: const Icon(Icons.refresh),
          label: const Text('Reset All'),
        ),
      ],
    );
  }
}
