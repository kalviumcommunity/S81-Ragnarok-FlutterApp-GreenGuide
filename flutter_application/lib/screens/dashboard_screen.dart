import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _authService = AuthService();
  final _firestoreService = FirestoreService();
  final _tipsFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Water Conservation';
  final List<String> _categories = [
    'Water Conservation',
    'Energy Savings',
    'Waste Reduction',
    'Transportation',
    'Shopping',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _addEcoTip() async {
    if (!_tipsFormKey.currentState!.validate()) {
      return;
    }

    final uid = _authService.currentUser?.uid;
    if (uid == null) return;

    try {
      await _firestoreService.addEcoTip(
        uid: uid,
        title: _titleController.text,
        description: _descriptionController.text,
        category: _selectedCategory,
      );

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
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
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
                  DropdownButtonFormField(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
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

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    final uid = user?.uid;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        // Hot Reload Demo: Changed text below
        title: Text('Welcome to Hot Reload, ${user?.displayName ?? 'User'}!'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: uid == null
          ? const Center(child: Text('Please log in'))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 32 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats section
                    FutureBuilder<Map<String, dynamic>>(
                      future: _firestoreService.getUserStats(uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData) {
                          return const Text('No data available');
                        }

                        final stats = snapshot.data!;
                        return GridView.count(
                          crossAxisCount: isTablet ? 4 : 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildStatCard(
                              'Total Tips',
                              stats['totalTips'].toString(),
                              Icons.lightbulb,
                              Colors.orange,
                              isTablet,
                            ),
                            _buildStatCard(
                              'Completed',
                              stats['completedTips'].toString(),
                              Icons.check_circle,
                              Colors.green,
                              isTablet,
                            ),
                            _buildStatCard(
                              'Pending',
                              stats['pendingTips'].toString(),
                              Icons.pending_actions,
                              Colors.blue,
                              isTablet,
                            ),
                            _buildStatCard(
                              'Completion',
                              '${stats['completionRate']}%',
                              Icons.trending_up,
                              Colors.purple,
                              isTablet,
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: isTablet ? 32 : 24),

                    // Eco Tips section
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

                    // Eco Tips List
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestoreService.streamUserEcoTips(uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(isTablet ? 32 : 24),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.eco,
                                    size: isTablet ? 80 : 64,
                                    color: Colors.grey[300],
                                  ),
                                  SizedBox(height: isTablet ? 16 : 12),
                                  Text(
                                    'No tips yet. Start adding eco tips!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: isTablet ? 16 : 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        final tips = snapshot.data!.docs;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tips.length,
                          itemBuilder: (context, index) {
                            final tip = tips[index];
                            final data = tip.data() as Map<String, dynamic>;

                            return Card(
                              elevation: 2,
                              margin: EdgeInsets.only(
                                bottom: isTablet ? 16 : 12,
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: data['completed'] ?? false,
                                  onChanged: (value) async {
                                    await _firestoreService.toggleEcoTipCompletion(
                                      uid: uid,
                                      tipId: tip.id,
                                      completed: value ?? false,
                                    );
                                    debugPrint('Tip "${data['title']}" marked as: ${value ?? false}');
                                  },
                                  activeColor: Colors.green[700],
                                ),
                                title: Text(
                                  data['title'] ?? '',
                                  style: TextStyle(
                                    fontSize: isTablet ? 16 : 14,
                                    decoration: (data['completed'] ?? false)
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: isTablet ? 8 : 4),
                                    Text(
                                      data['category'] ?? 'Other',
                                      style: TextStyle(
                                        fontSize: isTablet ? 12 : 10,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: isTablet ? 4 : 2),
                                    Text(
                                      data['description'] ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: isTablet ? 13 : 11,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red[600],
                                  onPressed: () async {
                                    await _firestoreService.deleteEcoTip(
                                      uid: uid,
                                      tipId: tip.id,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
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
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: isTablet ? 40 : 32, color: color),
          SizedBox(height: isTablet ? 12 : 8),
          Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: isTablet ? 4 : 2),
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 12 : 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
