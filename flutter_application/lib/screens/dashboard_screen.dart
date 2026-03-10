import 'package:flutter/material.dart';

import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _tipsFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<Map<String, dynamic>> _ecoTips = [
    {
      'title': 'Shorter showers',
      'description': 'Limit showers to 5 minutes to cut water use.',
      'category': 'Water Conservation',
      'completed': true,
    },
    {
      'title': 'Layer up instead of heating',
      'description': 'Wear extra layers in winter before cranking the thermostat.',
      'category': 'Energy Savings',
      'completed': false,
    },
    {
      'title': 'Bring reusable bags',
      'description': 'Keep a cloth bag in your car for last-minute trips.',
      'category': 'Shopping',
      'completed': false,
    },
  ];
  final List<String> _categories = [
    'Water Conservation',
    'Energy Savings',
    'Waste Reduction',
    'Transportation',
    'Shopping',
    'Other',
  ];
  String _selectedCategory = 'Water Conservation';

  void _addEcoTip() {
    if (!_tipsFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _ecoTips.insert(0, {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'category': _selectedCategory,
        'completed': false,
      });
    });

    _titleController.clear();
    _descriptionController.clear();

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Eco tip added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _toggleCompletion(int index, bool? value) {
    setState(() {
      _ecoTips[index]['completed'] = value ?? false;
    });
  }

  Map<String, String> _buildStats() {
    final total = _ecoTips.length;
    final completed = _ecoTips.where((tip) => tip['completed'] == true).length;
    final pending = total - completed;
    final completionRate = total == 0
        ? '0'
        : ((completed / total) * 100).toStringAsFixed(1);

    return {
      'totalTips': total.toString(),
      'completedTips': completed.toString(),
      'pendingTips': pending.toString(),
      'completionRate': completionRate,
    };
  }

  void _showAddTipDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 100 : 16,
          vertical: 24,
        ),
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 32 : 20),
          child: Form(
            key: _tipsFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Eco Tip',
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  SizedBox(height: isTablet ? 20 : 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'e.g., Take shorter showers',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 16 : 12),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: _categories
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value ?? 'Other';
                      });
                    },
                  ),
                  SizedBox(height: isTablet ? 16 : 12),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Details about this tip...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 24 : 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      SizedBox(width: isTablet ? 16 : 12),
                      ElevatedButton.icon(
                        onPressed: _addEcoTip,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Tip'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isTablet,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 20 : 12,
          vertical: isTablet ? 16 : 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: isTablet ? 16 : 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final stats = _buildStats();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GreenGuide Dashboard'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 32 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your eco journey stats',
              style: TextStyle(
                fontSize: isTablet ? 26 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            SizedBox(height: isTablet ? 24 : 16),
            GridView.count(
              crossAxisCount: isTablet ? 4 : 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStatCard(
                  'Total Tips',
                  stats['totalTips']!,
                  Icons.lightbulb,
                  Colors.orange,
                  isTablet,
                ),
                _buildStatCard(
                  'Completed',
                  stats['completedTips']!,
                  Icons.check_circle,
                  Colors.green,
                  isTablet,
                ),
                _buildStatCard(
                  'Pending',
                  stats['pendingTips']!,
                  Icons.pending_actions,
                  Colors.blue,
                  isTablet,
                ),
                _buildStatCard(
                  'Completion %',
                  stats['completionRate']!,
                  Icons.trending_up,
                  Colors.purple,
                  isTablet,
                ),
              ],
            ),
            SizedBox(height: isTablet ? 32 : 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Eco Tips',
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
                FloatingActionButton.extended(
                  onPressed: () => _showAddTipDialog(context),
                  backgroundColor: Colors.green[700],
                  icon: const Icon(Icons.add),
                  label: const Text('Add Tip'),
                ),
              ],
            ),
            SizedBox(height: isTablet ? 20 : 16),
            Expanded(
              child: _ecoTips.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.eco,
                            size: isTablet ? 96 : 72,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: isTablet ? 20 : 16),
                          Text(
                            'No tips yet. Add your first eco tip!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 18 : 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _ecoTips.length,
                      itemBuilder: (context, index) {
                        final tip = _ecoTips[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: isTablet ? 16 : 12),
                          elevation: 2,
                          child: ListTile(
                            leading: Checkbox(
                              value: tip['completed'] == true,
                              onChanged: (value) => _toggleCompletion(index, value),
                              activeColor: Colors.green[700],
                            ),
                            title: Text(
                              tip['title'] ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: tip['completed'] == true
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  tip['category'] ?? 'Other',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tip['description'] ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
