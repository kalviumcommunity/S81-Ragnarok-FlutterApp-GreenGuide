import 'package:flutter/material.dart';

class ResponsiveDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Responsive Design Demo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (screenWidth < 600) {
            // Mobile layout
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  height: 100,
                  color: Colors.tealAccent,
                  child: Center(child: Text('Mobile View')),
                ),
              ],
            );
          } else {
            // Tablet layout
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 250,
                  height: 150,
                  color: Colors.orangeAccent,
                  child: Center(child: Text('Tablet Left Panel')),
                ),
                Container(
                  width: 250,
                  height: 150,
                  color: Colors.tealAccent,
                  child: Center(child: Text('Tablet Right Panel')),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
