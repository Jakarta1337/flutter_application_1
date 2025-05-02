import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_signup/feautures/presentation/screens/search/bloc/counter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _MyCounterState();
}

class _MyCounterState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                if (state is CounterInitial) {
                  return Text('Count: 0', style: const TextStyle(fontSize: 24));
                } else if (state is CounterValueChangedState) {
                  return Text(
                    'Count: ${state.counter.toString()}',
                    style: const TextStyle(fontSize: 24),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // BlocProvider.of<CounterBloc>(context).add(DecrementEvent());
                    counterBloc.add(DecrementEvent());
                  },
                  child: const Text('Decrement'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(ResetEvent());
                  },
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(IncrementEvent());
                  },
                  child: const Text('Increment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
