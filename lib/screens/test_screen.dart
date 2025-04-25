// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/auth_bloc.dart';

class TestPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Correct! 🎉")));
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                state is AuthLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        context.read<AuthBloc>().add(
                          LoginRequested(email, password),
                        );
                      },
                      child: Text("check"),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
