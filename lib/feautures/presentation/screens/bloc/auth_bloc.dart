import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      final success = await authRepository.login(event.email, event.password);

      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Email or password incorrect!"));
      }
    });
  }
}
