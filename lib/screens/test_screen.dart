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
        body: Selector<Model, int>(
          selector: (context, model) => model.getI,
          builder: (context, i, child) {
            print(i);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("X=$i"),
                  ElevatedButton(
                    onPressed:
                        Provider.of<Model>(
                          context,
                          listen: false,
                        ).changeCounterValue,
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
  int i = 0;
  get getI => i;

  void changeCounterValue() {
    i++;
    notifyListeners();
  }
}
