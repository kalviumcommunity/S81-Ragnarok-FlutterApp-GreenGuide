import 'package:flutter/material.dart';

class AssetDemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assets Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Local image (logo)
            Image.asset('assets/images/logo.png', width: 120),
            SizedBox(height: 20),
            Text('Powered by Flutter', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flutter_dash, color: Colors.blue, size: 36),
                SizedBox(width: 10),
                Icon(Icons.android, color: Colors.green, size: 36),
                SizedBox(width: 10),
                Icon(Icons.apple, color: Colors.grey, size: 36),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
