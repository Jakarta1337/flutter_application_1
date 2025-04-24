import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: Scaffold(
        body: Consumer<Model>(
          builder: (context, model, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("c=${model.i}"),
                  ElevatedButton(
                    onPressed: model.changeCounterValue,
                    child: const Text('Press Me'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Model extends ChangeNotifier {
  int c = 10, i = 0;
  void changeCounterValue() {
    // i == 0 ? (c = 100, i = 1) : (c = 200, i = 0);
    i++;
    notifyListeners();
  }
}
