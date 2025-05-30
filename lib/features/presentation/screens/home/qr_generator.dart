import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorPage extends StatelessWidget {
  final String data;
  const QRGeneratorPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your QR Code')),
      body: Center(
        child: QrImageView(data: data, version: QrVersions.auto, size: 200.0),
      ),
    );
  }
}
