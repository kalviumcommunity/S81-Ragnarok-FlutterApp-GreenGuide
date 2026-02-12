import 'package:flutter/material.dart';

/// Responsive home screen demonstrating adaptive design for GreenGuide app
/// Uses MediaQuery, LayoutBuilder, and flexible widgets to adapt to various screen sizes
class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({super.key});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  int _selectedTipIndex = 0;

  // Environmental tips for GreenGuide
  final List<Map<String, String>> _ecoTips = [
    {
      'title': 'Reduce Water Usage',
      'description': 'Take shorter showers and fix leaky faucets to conserve water.',
      'icon': '💧'
    },
    {
      'title': 'Use Renewable Energy',
      'description':
          'Switch to solar panels or buy renewable energy from your provider.',
      'icon': '☀️'
    },
    {
      'title': 'Minimize Waste',
      'description': 'Practice the 3Rs: Reduce, Reuse, Recycle daily.',
      'icon': '♻️'
    },
    {
      'title': 'Plant Trees',
      'description': 'One tree can absorb up to 48 pounds of CO2 annually.',
      'icon': '🌱'
    },
    {
      'title': 'Sustainable Transport',
      'description': 'Bike, walk, or use public transport to reduce emissions.',
      'icon': '🚴'
    },
    {
      'title': 'Reduce Plastic',
      'description': 'Use reusable bags, bottles, and containers instead of plastic.',
      'icon': '🌍'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Main content area
              Expanded(
                child: _buildMainContent(context, constraints),
              ),
              // Footer
              _buildFooter(context),
            ],
          );
        },
      ),
    );
  }

  /// Build AppBar with responsive sizing
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return AppBar(
      elevation: 2,
      backgroundColor: Colors.green[700],
      title: Text(
        'GreenGuide',
        style: TextStyle(
          fontSize: isTablet ? 32 : 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(isTablet ? 8.0 : 4.0),
        child: Icon(
          Icons.eco,
          size: isTablet ? 32 : 24,
        ),
      ),
    );
  }

  /// Build main content area with responsive layout
  Widget _buildMainContent(BuildContext context, BoxConstraints constraints) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Dynamic padding and spacing
    final horizontalPadding = isTablet ? 32.0 : 16.0;
    final verticalPadding = isTablet ? 24.0 : 16.0;
    final spacing = isTablet ? 24.0 : 16.0;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeaderSection(context, isTablet, screenWidth),
            SizedBox(height: spacing),

            // Stats section - responsive grid
            _buildStatsSection(context, isTablet, screenWidth),
            SizedBox(height: spacing),

            // Tips section - adaptive layout
            if (isLandscape)
              _buildTipsLandscape(context, isTablet, screenWidth)
            else
              _buildTipsPortrait(context, isTablet, screenWidth),
          ],
        ),
      ),
    );
  }

  /// Header section with dynamic text sizing
  Widget _buildHeaderSection(
    BuildContext context,
    bool isTablet,
    double screenWidth,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to GreenGuide',
          style: TextStyle(
            fontSize: isTablet ? 36 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
          ),
        ),
        SizedBox(height: isTablet ? 12 : 8),
        Text(
          'Learn sustainable practices to protect our planet',
          style: TextStyle(
            fontSize: isTablet ? 18 : 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  /// Stats section with responsive grid
  Widget _buildStatsSection(
    BuildContext context,
    bool isTablet,
    double screenWidth,
  ) {
    final crossAxisCount = isTablet ? 3 : 2;
    final childAspectRatio = isTablet ? 1.2 : 1.0;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: isTablet ? 16 : 12,
      crossAxisSpacing: isTablet ? 16 : 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          title: 'CO2 Saved',
          value: '50kg',
          icon: Icons.cloud_off,
          isTablet: isTablet,
        ),
        _buildStatCard(
          title: 'Trees Planted',
          value: '120',
          icon: Icons.nature,
          isTablet: isTablet,
        ),
        _buildStatCard(
          title: 'Water Conserved',
          value: '1000L',
          icon: Icons.water_drop,
          isTablet: isTablet,
        ),
      ],
    );
  }

  /// Individual stat card with FittedBox for scaling
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required bool isTablet,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!, width: 1.5),
      ),
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(
              icon,
              size: isTablet ? 40 : 32,
              color: Colors.green[700],
            ),
          ),
          SizedBox(height: isTablet ? 8 : 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: isTablet ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
          ),
          SizedBox(height: isTablet ? 4 : 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTablet ? 12 : 10,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Portrait mode tips section
  Widget _buildTipsPortrait(
    BuildContext context,
    bool isTablet,
    double screenWidth,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Eco Tips (${_ecoTips.length} available)',
          style: TextStyle(
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
          ),
        ),
        SizedBox(height: isTablet ? 16 : 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              _ecoTips.length,
              (index) => Padding(
                padding: EdgeInsets.only(right: isTablet ? 16 : 12),
                child: _buildTipCard(index, isTablet, isMobile: true),
              ),
            ),
          ),
        ),
        SizedBox(height: isTablet ? 16 : 12),
        _buildSelectedTipDetails(isTablet),
      ],
    );
  }

  /// Landscape mode tips section with grid layout
  Widget _buildTipsLandscape(
    BuildContext context,
    bool isTablet,
    double screenWidth,
  ) {
    final crossAxisCount = isTablet ? 4 : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Eco Tips (${_ecoTips.length} available)',
          style: TextStyle(
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
          ),
        ),
        SizedBox(height: isTablet ? 16 : 12),
        GridView.count(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1.2,
          mainAxisSpacing: isTablet ? 12 : 8,
          crossAxisSpacing: isTablet ? 12 : 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            _ecoTips.length,
            (index) => _buildTipCard(index, isTablet, isMobile: false),
          ),
        ),
      ],
    );
  }

  /// Individual tip card
  Widget _buildTipCard(
    int index,
    bool isTablet, {
    required bool isMobile,
  }) {
    final tip = _ecoTips[index];
    final isSelected = _selectedTipIndex == index;
    final cardWidth = isMobile ? (isTablet ? 200.0 : 160.0) : null;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTipIndex = index;
        });
      },
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[700] : Colors.green[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green[700]! : Colors.green[200]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        padding: EdgeInsets.all(isTablet ? 16 : 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tip['icon']!,
              style: TextStyle(fontSize: isTablet ? 36 : 28),
            ),
            SizedBox(height: isTablet ? 8 : 6),
            Flexible(
              child: Text(
                tip['title']!,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.green[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Display selected tip details
  Widget _buildSelectedTipDetails(bool isTablet) {
    final tip = _ecoTips[_selectedTipIndex];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[300]!, width: 1.5),
      ),
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                tip['icon']!,
                style: TextStyle(fontSize: isTablet ? 40 : 32),
              ),
              SizedBox(width: isTablet ? 16 : 12),
              Expanded(
                child: Text(
                  tip['title']!,
                  style: TextStyle(
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 12 : 10),
          Text(
            tip['description']!,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          SizedBox(height: isTablet ? 16 : 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${tip['title']} added to favorites!'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.favorite_border),
                  label: const Text('Favorite'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: EdgeInsets.symmetric(vertical: isTablet ? 12 : 8),
                  ),
                ),
              ),
              SizedBox(width: isTablet ? 12 : 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${tip['title']} shared!'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.green[700]!),
                    padding: EdgeInsets.symmetric(vertical: isTablet ? 12 : 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Footer section with navigation and actions
  Widget _buildFooter(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border(top: BorderSide(color: Colors.green[200]!, width: 1)),
      ),
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFooterButton(
                icon: Icons.home,
                label: 'Home',
                isTablet: isTablet,
                onPressed: () {},
              ),
              _buildFooterButton(
                icon: Icons.favorite,
                label: 'Favorites',
                isTablet: isTablet,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('View saved favorites')),
                  );
                },
              ),
              _buildFooterButton(
                icon: Icons.bar_chart,
                label: 'Stats',
                isTablet: isTablet,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('View your impact statistics')),
                  );
                },
              ),
              _buildFooterButton(
                icon: Icons.settings,
                label: 'Settings',
                isTablet: isTablet,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Open settings')),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: isTablet ? 16 : 12),
          Text(
            '© 2024 GreenGuide - Making sustainability accessible',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 12 : 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// Footer button widget
  Widget _buildFooterButton({
    required IconData icon,
    required String label,
    required bool isTablet,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isTablet ? 32 : 24,
            color: Colors.green[700],
          ),
          SizedBox(height: isTablet ? 4 : 2),
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 12 : 10,
              color: Colors.green[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
