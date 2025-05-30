import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: MobileScanner(
        onDetect: (capture) {
          final barcode = capture.barcodes.first;
          final String? code = barcode.rawValue;

          if (code != null) {
            Navigator.of(context).pop(); // Close scanner
            // Do something with the code
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Scanned: $code')));
          }
        },
      ),
    );
  }
}
