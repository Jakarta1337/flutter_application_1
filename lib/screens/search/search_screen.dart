import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _MyCounterState();
}

class _MyCounterState extends State<SearchPage> {
  int count = 0;
  bool showError = false;

  void incrementCount() {
    setState(() {
      if (count < 10) {
        count++;
        showError = false;
      }
    });
  }

  void decrementCount() {
    setState(() {
      if (count > 0) {
        count--;
        showError = false;
      } else {
        showError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $count', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: count < 10 ? incrementCount : null,
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: count > 0 ? decrementCount : null,
                  child: const Text('Decrement'),
                ),
              ],
            ),
            if (showError || count <= 0)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Count cannot be negative or zero!',
                  style: TextStyle(color: Colors.red),
                ),
              )
            else if (count == 10)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Maximum count reached!',
                  style: TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
