import 'package:flutter/material.dart';

import '../data/plant_library.dart';

class PlantScanScreen extends StatefulWidget {
  const PlantScanScreen({super.key});

  @override
  State<PlantScanScreen> createState() => _PlantScanScreenState();
}

class _PlantScanScreenState extends State<PlantScanScreen> {
  final _codeController = TextEditingController();
  String? _status;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _submitCode() {
    final code = _codeController.text;
    if (code.isEmpty) {
      setState(() {
        _status = 'Enter a plant code or scan to continue.';
      });
      return;
    }

    final added = PlantLibrary.addPlantFromCode(code);
    setState(() {
      _status = added
          ? 'Plant added! You can find it in "My Plants".'
          : 'No plant matches that code yet. Try ECO001 / ECO002 / ECO003.';
    });

    if (added) {
      _codeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan or Add Plant'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scan a QR tag or type the plant code to sync it automatically.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Plant code (e.g., ECO001)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.qr_code),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _submitCode,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Sync Plant'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
            ),
            const SizedBox(height: 12),
            if (_status != null)
              Text(
                _status!,
                style: TextStyle(
                  color: _status!.startsWith('Plant added') ? Colors.green[700] : Colors.red[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Sample Plant Codes:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('• ECO001 = Snake Plant'),
                Text('• ECO002 = Aloe Vera'),
                Text('• ECO003 = Mini Rose'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
