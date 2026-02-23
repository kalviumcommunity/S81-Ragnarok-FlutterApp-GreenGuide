import 'package:flutter/material.dart';
import '../widgets/info_card.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: InfoCard(
          title: 'Account Info',
          subtitle: 'User details and subscription',
          icon: Icons.info,
        ),
      ),
    );
  }
}
