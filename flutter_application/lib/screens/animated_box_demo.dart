import 'package:flutter/material.dart';

class AnimatedBoxDemo extends StatefulWidget {
  @override
  _AnimatedBoxDemoState createState() => _AnimatedBoxDemoState();
}

class _AnimatedBoxDemoState extends State<AnimatedBoxDemo> {
  bool _toggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedContainer Demo')),
      body: Center(
        child: AnimatedContainer(
          width: _toggled ? 200 : 100,
          height: _toggled ? 100 : 200,
          color: _toggled ? Colors.teal : Colors.orange,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Center(
            child: Text(
              'Tap Me!',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _toggled = !_toggled;
          });
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
